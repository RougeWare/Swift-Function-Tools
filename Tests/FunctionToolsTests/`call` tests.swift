//
//  call tests.swift
//  FunctionTools
//
//  Created by Ky on 2026-03-24.
//

import Testing

import FunctionTools



private var throwingValue_67_nothrows: Int { get throws {
    67
}}


private var throwingValue_snafu_nothrows: String { get throws {
    "snafu"
}}



// MARK: - call<T>(_: ThrowingGenerator<T>) rethrows -> T

/// Validates the throwing-generator-invocation overload.
///
/// Unlike the factory overloads, this overload *calls* the generator immediately
/// and returns its result — or propagates its error. The primary use-case is
/// flattening a `[ThrowingGenerator<T>]` via `map(echo)`.
///
/// Overload resolved by the `ThrowingGenerator<T>` argument type.
@Suite("`call` — `ThrowingGenerator` invocation")
struct CallThrowingGeneratorTests {
    
    @Test("Returns the value produced by a non-throwing `ThrowingGenerator<Int>`")
    func nonThrowingGeneratorReturnsInt() throws {
        let result: Int = try call({ try throwingValue_67_nothrows } as ThrowingGenerator<Int>)
        #expect(result == 67)
    }
    
    
    @Test("Returns the value produced by a non-throwing `ThrowingGenerator<String>`")
    func nonThrowingGeneratorReturnsString() throws {
        let result = try call({ try throwingValue_snafu_nothrows } as ThrowingGenerator<String>)
        #expect(result == "snafu")
    }
    
    
    @Test("Returns the value produced by a non-throwing `ThrowingGenerator<Point>`")
    func nonThrowingGeneratorReturnsStruct() throws {
        let expected = Point(x: 2, y: 9)
        let result = try call({ expected } as ThrowingGenerator<Point>)
        #expect(result == expected)
    }
    
    
    @Test("Propagates an error thrown by a `ThrowingGenerator<Int>`")
    func throwingGeneratorPropagatesError() {
        // `echo` must rethrow without wrapping or swallowing the original error.
        #expect(throws: TestError.self) {
            try call({ throw TestError() } as ThrowingGenerator<Int>)
        }
    }
    
    
    @Test("Propagates an error thrown by a `ThrowingGenerator<String>`")
    func throwingStringGeneratorPropagatesError() {
        #expect(throws: TestError.self) {
            try call({ throw TestError() } as ThrowingGenerator<String>)
        }
    }
    
    
    @Test("Can flatten a `[ThrowingGenerator<Int>]` via `map(echo)`")
    func flattenCollectionOfGenerators() throws {
        // This is the canonical usage shown in the documentation.
        let generators: [ThrowingGenerator<Int>] = [{ 1 }, { 2 }, { 3 }]
        let values = try generators.map(call)
        #expect(values == [1, 2, 3])
    }
    
    
    @Test("Stops at the first throwing generator when used with `map(echo)`")
    func mapStopsAtFirstThrowingGenerator() {
        var callCount = 0
        let generators: [ThrowingGenerator<Int>] = [
            { callCount += 1; return 1 },
            { throw TestError() },
            { callCount += 1; return 3 },   // must never be reached
        ]
        #expect(throws: TestError.self) {
            _ = try generators.map(call)
        }
        // Only the first generator should have been invoked before the throw.
        #expect(callCount == 1)
    }
}



// MARK: - call<T>(_: AsyncGenerator<T>) async -> T

/// Validates the async throwing-generator-invocation overload.
///
/// Like its synchronous counterpart, this overload awaits and invokes the generator
/// immediately. It is the async analogue for flattening collections of async generators.
///
/// Overload resolved by the `AsyncThrowingGenerator<T, Failure>` argument type.
@Suite("`call` — `AsyncThrowingGenerator` invocation")
struct CallAsyncGeneratorTests {
    
    
    @Test("Returns the value produced by a non-throwing `AsyncThrowingGenerator<Int, _>`")
    func nonThrowingAsyncGeneratorReturnsInt() async throws {
        let result = await call({ 77 } as AsyncGenerator<Int>)
        #expect(result == 77)
    }
    
    
    @Test("Returns the value produced by a non-throwing `AsyncThrowingGenerator<String, _>`")
    func nonThrowingAsyncGeneratorReturnsString() async throws {
        let result = await call({ "async produced" } as AsyncGenerator<String>)
        #expect(result == "async produced")
    }
    
    
    @Test("Returns the value produced by a non-throwing `AsyncThrowingGenerator<Point, _>`")
    func nonThrowingAsyncGeneratorReturnsStruct() async throws {
        let expected = Point(x: 11, y: 22)
        let result = await call({ expected } as AsyncGenerator<Point>)
        #expect(result == expected)
    }
    
    
    @available(macOS 15, *)
    @Test("Can flatten a sequence of `AsyncThrowingGenerator<Int, _>` values iteratively")
    func flattenSequenceOfAsyncGenerators() async throws {
        // Mirrors the `map(echo)` pattern from the documentation, adapted for async.
        let generators: [AsyncGenerator<Int>] = [{ 10 }, { 20 }, { 30 }]
        var results: [Int] = []
        for gen in generators {
            await results.append(call(gen))
        }
        #expect(results == [10, 20, 30])
    }
    
    
    @Test("Correctly awaits a generator that itself suspends before producing a value")
    func generatorThatSuspendsIsAwaited() async throws {
        // Verifies that `echo` does not short-circuit the async lifecycle —
        // i.e., it genuinely awaits the generator rather than returning prematurely.
        let gen: AsyncGenerator<Int> = {
            await Task.yield()
            return 42
        }
        let result = await call(gen)
        #expect(result == 42)
    }
}



// MARK: - call<T, Failure: Error>(_: AsyncThrowingGenerator<T, Failure>) async throws(Failure) -> T

/// Validates the async throwing-generator-invocation overload.
///
/// Like its synchronous counterpart, this overload awaits and invokes the generator
/// immediately. It is the async analogue for flattening collections of async generators.
///
/// Overload resolved by the `AsyncThrowingGenerator<T, Failure>` argument type.
@Suite("`call` — `AsyncThrowingGenerator` invocation")
struct CallAsyncThrowingGeneratorTests {
    
    
    @Test("Returns the value produced by a non-throwing `AsyncThrowingGenerator<Int, _>`")
    func nonThrowingAsyncGeneratorReturnsInt() async throws {
        let result = try await call({ 77 } as AsyncThrowingGenerator<Int, TestError>)
        #expect(result == 77)
    }
    
    
    @Test("Returns the value produced by a non-throwing `AsyncThrowingGenerator<String, _>`")
    func nonThrowingAsyncGeneratorReturnsString() async throws {
        let result = try await call({ "async produced" } as AsyncThrowingGenerator<String, TestError>)
        #expect(result == "async produced")
    }
    
    
    @Test("Returns the value produced by a non-throwing `AsyncThrowingGenerator<Point, _>`")
    func nonThrowingAsyncGeneratorReturnsStruct() async throws {
        let expected = Point(x: 11, y: 22)
        let result = try await call({ expected } as AsyncThrowingGenerator<Point, TestError>)
        #expect(result == expected)
    }
    
    
    @Test("Propagates an error thrown by an `AsyncThrowingGenerator<Int, _>`")
    func throwingAsyncGeneratorPropagatesError() async {
        // `echo` must rethrow without wrapping or transforming the original async error.
        await #expect(throws: TestError.self) {
            try await call({ () throws(TestError) in throw TestError() } as AsyncThrowingGenerator<Int, TestError>)
        }
    }
    
    
    @Test("Propagates an error thrown by an `AsyncThrowingGenerator<String, _>`")
    func throwingAsyncStringGeneratorPropagatesError() async {
        await #expect(throws: TestError.self) {
            try await call({ () throws(TestError) in throw TestError() } as AsyncThrowingGenerator<String, TestError>)
        }
    }
    
    
    @available(macOS 15, *)
    @Test("Can flatten a sequence of `AsyncThrowingGenerator<Int, _>` values iteratively")
    func flattenSequenceOfAsyncGenerators() async throws {
        // Mirrors the `map(echo)` pattern from the documentation, adapted for async.
        let generators: [AsyncThrowingGenerator<Int, TestError>] = [{ 10 }, { 20 }, { 30 }]
        var results: [Int] = []
        for gen in generators {
            try await results.append(call(gen))
        }
        #expect(results == [10, 20, 30])
    }
    
    
    @Test("Correctly awaits a generator that itself suspends before producing a value")
    func generatorThatSuspendsIsAwaited() async throws {
        // Verifies that `echo` does not short-circuit the async lifecycle —
        // i.e., it genuinely awaits the generator rather than returning prematurely.
        let gen: AsyncThrowingGenerator<Int, TestError> = {
            await Task.yield()
            return 42
        }
        let result = try await call(gen)
        #expect(result == 42)
    }
}
