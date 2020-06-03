//
//  Constant.swift
//  FunctionTools
//
//  Created by Ben Leggiero on 2020-06-03.
//  Copyright © 2020 Ben Leggiero BS-1-PS.
//

import Foundation



/// Identical to `echo<T>(_ value: T) -> Generator<T>` - returns a function which always returns the given value.
/// This is useful when making a test/preview where you always want the same output.
///
/// ```swift
/// Lazy(initializer: constant("Foo"))
/// ```
///
/// - Parameter value: The value which the returned function will always return
/// - Returns: A function which always returns `value`
@inline(__always)
public func constant<T>(_ value: T) -> Generator<T> { echo(value) }



/// Returns a function which ignores its only input, and always returns the given value.
/// This is useful when making a test/preview where you always want the same output.
///
/// ```swift
/// MyView(textTranslator: constant("Bar")) // imagining `textTranslator` is like `(String) -> String`
/// ```
///
/// - Parameter value: The value which the returned function will always return
/// - Returns: A function which always returns `value`, no matter its input
@inlinable
public func constant<T, Ignored>(_ value: T) -> Transformer<Ignored, T> {{ _ in value }}
