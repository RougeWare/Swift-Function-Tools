//
//  Call.swift
//  FunctionTools
//
//  Created by Ben Leggiero on 2020-04-02.
//  Copyright © 2020 Ben Leggiero BS-1-PS.
//

import Foundation



// MARK: - Blind callbacks

/// A utility function which simply calls the given function. This is useful for compressing higher-order functions
///
/// For example:
/// ```swift
/// let someFunctions: [ThrowingBlindCallback<SendError>] = [
///     { try send("Hello") },
///     { try send("World!") },
/// ]
///
/// try someFunctions.forEach(call)
/// ```
///
/// - Parameter callee: The function to call
/// - Throws: Anything `callee` throws
@inlinable
public func call<Failure: Error>(_ callee: ThrowingBlindCallback<Failure>) rethrows {
    try callee()
}



/// A utility function which simply calls the given function. This is useful for compressing higher-order functions
///
/// For example:
/// ```swift
/// let someFunctions: [BlindCallback] = [
///     { print("Hello") },
///     { print("World!") },
/// ]
///
/// someFunctions.forEach(call)
/// ```
///
/// - Parameter callee: The function to call
@inlinable
public func call(_ callee: BlindCallback) {
    callee()
}



// MARK: - Generators

/// A utility function which simply returns the result of the given function.
/// This is useful for flattening collections of generators.
///
/// For example:
/// ```swift
/// let values = generators.map(call)
/// ```
///
/// - Parameter inputGenerator: The function which generates a value
/// - Throws: Anything `inputGenerator` throws
@inlinable
public func call<T>(_ inputGenerator: Generator<T>) -> T { inputGenerator() }



/// A utility function which simply returns the result of the given function.
/// This is useful for flattening collections of generators.
///
/// For example:
/// ```swift
/// let values = try failableGenerators.map(call)
/// ```
///
/// - Parameter inputGenerator: The function which generates a value
/// - Throws: Anything `inputGenerator` throws
@inlinable
public func call<T, Failure: Error>(_ inputGenerator: ThrowingGenerator<T, Failure>) throws(Failure) -> T { try inputGenerator() }



/// A utility function which simply returns the result of the given function.
/// This is useful for flattening collections of generators.
///
/// For example:
/// ```swift
/// async let values = asyncGenerators.map(call).collect()
/// ```
///
/// - Parameter inputGenerator: The function which generates a value
/// - Throws: Anything `inputGenerator` throws
@available(macOS 10.15, *)
@available(iOS 13, *)
@available(tvOS 13, *)
@available(watchOS 6, *)
@inlinable
public func call<T>(_ generator: AsyncGenerator<T>) async -> T { await generator() }



/// A utility function which simply returns the result of the given function.
/// This is useful for flattening collections of generators.
///
/// For example:
/// ```swift
/// async let values = try asyncFailableGenerators.map(call).collect()
/// ```
///
/// - Parameter inputGenerator: The function which generates a value
/// - Throws: Anything `inputGenerator` throws
@available(macOS 10.15, *)
@available(iOS 13, *)
@available(tvOS 13, *)
@available(watchOS 6, *)
@inlinable
public func call<T, Failure: Error>(_ generator: AsyncThrowingGenerator<T, Failure>) async throws(Failure) -> T { try await generator() }
