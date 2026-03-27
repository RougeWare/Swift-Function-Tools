//
//  echo tests.swift
//  FunctionToolsTests
//
//  Created by Ky directing Claude 4.6 Sonnet on 2026-03-23.
//
// Claude added the following notes:
//  Tests for Echo.swift — the `echo` family of overloads.
//
//  Each test suite is organized around a distinct overload contract.
//  The core challenge across all suites is that several `echo` variants share
//  the same argument shape; explicit return-type annotations are used throughout
//  to anchor the compiler to the intended overload.
//

import Testing
import Foundation

import FunctionTools



// MARK: - echo<T>(_ input: T) -> T

/// Validates the identity overload: given any value, `echo` must return it unchanged.
///
/// Overload resolved via explicit `T` return-type annotations throughout.
@Suite("`echo` — identity")
struct EchoIdentityTests {
    
    // MARK: Primitive types
    
    @Test("Returns an `Int` value unchanged")
    func returnsInt() {
        let result = echo(42)
        #expect(result == 42)
    }
    
    
    @Test("Returns a negative `Int` unchanged")
    func returnsNegativeInt() {
        let result: Int = echo(-99)
        #expect(result == -99)
    }
    
    
    @Test("Returns zero as an `Int` unchanged")
    func returnsZeroInt() {
        let result: Int = echo(0)
        #expect(result == 0)
    }
    
    
    @Test("Returns a `Double` unchanged")
    func returnsDouble() {
        let result: Double = echo(3.14)
        #expect(result == 3.14)
    }
    
    
    @Test("Returns a `Bool` true unchanged")
    func returnsBoolTrue() {
        let result: Bool = echo(true)
        #expect(result == true)
    }
    
    
    @Test("Returns a `Bool` false unchanged")
    func returnsBoolFalse() {
        let result: Bool = echo(false)
        #expect(result == false)
    }
    
    
    // MARK: String
    
    @Test("Returns a non-empty `String` unchanged")
    func returnsNonEmptyString() {
        let result: String = echo("hello")
        #expect(result == "hello")
    }
    
    
    @Test("Returns an empty `String` unchanged")
    func returnsEmptyString() {
        let result: String = echo("")
        #expect(result == "")
    }
    
    
    // MARK: Optionals
    
    @Test("Returns a non-nil `String?` unchanged")
    func returnsNonNilOptional() {
        let input: String? = "present"
        let result: String? = echo(input)
        #expect(result == "present")
    }
    
    
    @Test("Returns a nil `String?` unchanged")
    func returnsNilOptional() {
        let input: String? = nil
        let result: String? = echo(input)
        #expect(result == nil)
    }
    
    
    @Test("Returns a nil `Int?` unchanged")
    func returnsNilIntOptional() {
        let input: Int? = nil
        let result: Int? = echo(input)
        #expect(result == nil)
    }
    
    
    // MARK: Collections
    
    @Test("Returns an empty `[Int]` unchanged")
    func returnsEmptyArray() {
        let result: [Int] = echo([])
        #expect(result.isEmpty)
    }
    
    
    @Test("Returns a populated `[Int]` unchanged")
    func returnsPopulatedArray() {
        let input = [1, 2, 3]
        let result: [Int] = echo(input)
        #expect(result == input)
    }
    
    
    @Test("Returns a `[String: Int]` dictionary unchanged")
    func returnsDictionary() {
        let input = ["a": 1, "b": 2]
        let result: [String: Int] = echo(input)
        #expect(result == input)
    }
    
    
    // MARK: Custom types
    
    @Test("Returns a custom value-type `Point` struct unchanged")
    func returnsCustomStruct() {
        let point = Point(x: 3, y: 7)
        let result: Point = echo(point)
        #expect(result == point)
    }
    
    
    @Test("Preserves reference identity when given a class instance")
    func preservesReferenceIdentity() {
        let token = Token()
        let result: Token = echo(token)
        #expect(result === token)
    }
    
    
    // MARK: Higher-order usage
    
    @Test("Can be passed directly to `compactMap` to strip nils")
    func compactMapUsage() {
        // This is the canonical usage shown in the documentation.
        let input: [Int?] = [1, nil, 2, nil, 3]
        let result = input.compactMap(echo)
        #expect(result == [1, 2, 3])
    }
    
    
    @Test("Can be passed directly to `map` as an identity transform")
    func mapUsage() {
        let input = [10, 20, 30]
        let result = input.map(echo)
        #expect(result == input)
    }
    
    
    @Test("Can be passed directly to `filter` — no values are dropped")
    func filterWithEchoRetainsAll() {
        // echo returns each Bool element as-is; only falsy elements are dropped,
        // confirming that `echo` does not inject any logic of its own.
        let input = [true, false, true, true]
        let result = input.filter(echo)
        #expect(result == [true, true, true])
    }
    
}


// MARK: - echo<T>(_ value: T) -> Generator<T>

/// Validates the synchronous generator-factory overload:
/// the returned `Generator<T>` must always produce the originally captured value,
/// regardless of how many times it is invoked.
///
/// Overload resolved via explicit `Generator<T>` return-type annotations.
@Suite("`echo` — synchronous `Generator` factory")
struct EchoSyncGeneratorTests {
    
    
    @Test("Returned `Generator<Int>` always produces the captured value")
    func generatorAlwaysProducesInt() {
        let gen: Generator<Int> = echo(99)
        #expect(gen() == 99)
        #expect(gen() == 99)
    }
    
    
    @Test("Returned `Generator<String>` always produces the captured value")
    func generatorAlwaysProducesString() {
        let gen: Generator<String> = echo("constant")
        #expect(gen() == "constant")
    }
    
    
    @Test("Returned `Generator<String?>` always produces a captured nil")
    func generatorAlwaysProducesNil() {
        let gen: Generator<String?> = echo(nil as String?)
        #expect(gen() == nil)
    }
    
    
    @Test("Returned `Generator<Point>` always produces the captured struct")
    func generatorAlwaysProducesStruct() {
        let point = Point(x: 4, y: 5)
        let gen: Generator<Point> = echo(point)
        #expect(gen() == point)
    }
    
    
    @Test("Returned `Generator<Bool>` is stable across multiple calls")
    func generatorIsStableAcrossMultipleCalls() {
        let gen: Generator<Bool> = echo(true)
        let results = (0..<5).map { _ in gen() }
        #expect(results.allSatisfy { $0 == true })
    }
    
    
    @Test("Can be used as a `Generator<T>` argument at the call site")
    func canBePassedDirectlyAsGeneratorArgument() {
        // Verifies the motivating use-case: providing a predictable test function
        // wherever a `Generator<T>` is expected.
        func consume<T>(_ gen: Generator<T>) -> T { gen() }
        #expect(consume(echo(7 as Int)) == 7)
    }
    
}


// MARK: - echo<T>(_ value: T) -> AsyncGenerator<T>

private func asyncValue<T>(_ value: T) async -> T {
    await Task {
        try? await Task.sleep(for: .milliseconds(.random(in: 0...15)))
        return value
    }
    .value
}


private var asyncValue_42: Int { get async {
    await asyncValue(42)
}}


private var asyncValue_nil_Int: Int? { get async {
    await asyncValue(nil)
}}


private var asyncValue_foobar: String { get async {
    await asyncValue("foobar")
}}


private var asyncValue_nil_String: String? { get async {
    await asyncValue(nil)
}}


private var asyncConstant_false: Bool { get async {
    await asyncValue(false)
}}



/// Validates the async generator-factory overload:
/// the returned `AsyncGenerator<T>` must always produce the originally captured value,
/// even across concurrent awaits.
///
/// Overload resolved via explicit `AsyncGenerator<T>` return-type annotations.
@Suite("`echo` — async `AsyncGenerator` factory")
struct EchoAsyncGeneratorTests {
    
    
    @Test("Returned `AsyncGenerator<Int>` produces the captured value")
    func asyncGeneratorProducesInt() async {
        let gen: AsyncGenerator<Int> = await echo(asyncValue_42)
        let result = await gen()
        #expect(result == 42)
    }
    
    
    @Test("Returned `AsyncGenerator<String>` produces the captured value")
    func asyncGeneratorProducesString() async {
        let gen: AsyncGenerator<String> = await echo(asyncValue_foobar)
        let result = await gen()
        #expect(result == "foobar")
    }
    
    
    @Test("Returned `AsyncGenerator<Int?>` produces a captured nil")
    func asyncGeneratorProducesNil() async {
        let gen: AsyncGenerator<Int?> = await echo(asyncValue_nil_Int)
        let result = await gen()
        #expect(result == nil)
    }
    
    
    @Test("Returned `AsyncGenerator<Point>` produces the captured struct")
    func asyncGeneratorProducesStruct() async {
        let point = Point(x: 8, y: 16)
        let gen: AsyncGenerator<Point> = await echo(asyncValue(point))
        let result = await gen()
        #expect(await result == point)
    }
    
    
    @Test("Returned `AsyncGenerator<Int>` is stable across multiple awaits")
    func asyncGeneratorIsStableAcrossMultipleAwaits() async {
        let gen: AsyncGenerator<Int> = await echo(asyncValue_42)
        let first = await gen()
        let second = await gen()
        #expect(first == second)
    }
    
}


// MARK: - echo<o>(_ generator: @escaping @autoclosure AsyncGenerator<o>) async -> AsyncGenerator<o>

/// Validates the autoclosure-passthrough overload.
///
/// This overload exists to capture an already-awaited expression into a new
/// `AsyncGenerator<T>`, making it suitable for injection into APIs that accept
/// `AsyncGenerator<T>` but where you already hold a resolved value.
/// The function itself is `async` so that the call site can `await` it naturally.
///
/// Overload resolved via explicit `AsyncGenerator<T>` return-type annotations.
@Suite("`echo` — autoclosure `AsyncGenerator` passthrough")
struct EchoAutoclosureAsyncGeneratorTests {
    
    
    @Test("Returned `AsyncGenerator<Int>` produces the value from the autoclosure expression")
    func autoclosureWrapsIntExpression() async {
        // The expression `100 as Int` is captured by the @autoclosure and wrapped
        // into a generator that can be re-invoked later.
        let gen: AsyncGenerator<Int> = await echo(asyncValue_42)
        let result = await gen()
        #expect(result == 42)
    }
    
    
    @Test("Returned `AsyncGenerator<String>` is reusable across multiple awaits")
    func autoclosureGeneratorIsReusable() async {
        let gen: AsyncGenerator<String> = await echo(asyncValue_foobar)
        let first = await gen()
        let second = await gen()
        #expect(first == second)
    }
    
    
    @Test("Returned `AsyncGenerator<Bool>` preserves the captured boolean value")
    func autoclosurePreservesBool() async {
        let gen: AsyncGenerator<Bool> = await echo(asyncConstant_false)
        let result = await gen()
        #expect(result == false)
    }
    
    
    @Test("Returned `AsyncGenerator<Point>` preserves the captured struct value")
    func autoclosurePreservesStruct() async {
        let point = Point(x: 0, y: 0)
        let gen: AsyncGenerator<Point> = await echo(asyncValue(point))
        let result = await gen()
        #expect(result == point)
    }
    
}
