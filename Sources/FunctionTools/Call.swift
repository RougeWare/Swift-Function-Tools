//
//  Call.swift
//  FunctionTools
//
//  Created by Ben Leggiero on 2020-04-02.
//  Copyright © 2020 Ben Leggiero BS-1-PS.
//

import Foundation



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
/// - Throws: Anything `callee` throws
@inlinable
public func call(_ callee: ThrowingBlindCallback) rethrows {
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
