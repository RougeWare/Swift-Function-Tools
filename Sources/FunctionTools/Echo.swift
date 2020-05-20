//
//  Echo.swift
//  FunctionTools
//
//  Created by Ben Leggiero on 2020-05-20.
//  Copyright © 2020 Ben Leggiero BS-1-PS.
//

import Foundation



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


/// A utility function which simply returns the result of the given function.
/// This is useful for flattening collections of generators.
///
/// For example:
/// ```swift
/// let values = generators.map(echo)
/// ```
///
/// - Parameter inputGenerator: The function which generates a value
/// - Throws: Anything `inputGenerator` throws
@inlinable
public func echo<T>(_ inputGenerator: ThrowingGenerator<T>) rethrows -> T { try inputGenerator() }
