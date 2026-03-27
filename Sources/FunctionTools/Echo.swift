//
//  Echo.swift
//  FunctionTools
//
//  Created by Ben Leggiero on 2020-05-20.
//  Copyright © 2020 Ben Leggiero BS-1-PS.
//

import Foundation



// MARK: - `echo` a value

/// A utility function which simply returns the given value.
/// This is useful for reusing the input of higher-order functions.
///
/// For example:
/// ```swift
/// let withoutNils = arrayOfOptionals.compactMap(echo)
/// ```
///
/// - Parameter input: The value to return
@inlinable
public func echo<T>(_ input: T) -> T { input }



// MARK: - `echo` a value generator

/// A utility function which simply returns a function which always returns the given value.
/// This is useful for providing a predictable test function
///
/// For example:
/// ```swift
/// Lazy(initializer: echo("Foo"))
/// ```
///
/// - Parameter value: The value to return from the returned function
/// - Returns: A function which always returns the given value
@inlinable
@_disfavoredOverload
public func echo<T>(_ value: T) -> Generator<T> {{ value }}



/// A utility function which simply returns a function which always returns the given value.
/// This is useful for providing a predictable test function
///
/// For example:
/// ```swift
/// AsyncLazy(initializer: echo("Foo"))
/// ```
///
/// - Parameter value: The value to return from the returned function
/// - Returns: A function which always returns the given value
@available(macOS 10.15, *)
@available(iOS 13, *)
@available(tvOS 13, *)
@available(watchOS 6, *)
@inlinable
@_disfavoredOverload
public func echo<T>(_ value: T) -> AsyncGenerator<T> {{ value }}
