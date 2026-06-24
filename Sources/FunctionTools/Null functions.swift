//
//  Null functions.swift
//  FunctionTools
//
//  Created by Ben Leggiero on 2020-04-16.
//  Copyright © 2020 Ben Leggiero BS-1-PS.
//



/// A function which does nothing, and will always be optimized away. Useful for when another function needs to take a
/// callback but you have nothing to do when it calls it.
///
/// - SeeAlso: ``blackhole(_:)`` for a version that's NEVER optimized-out
@inline(__always)
@Sendable
public func null() { }


/// A function which takes one value and does nothing with it, and will always be optimized away. Useful for when
/// another function needs to take a callback but you have nothing to do when it calls it.
///
/// For example:
/// ```swift
/// myObject.someAsyncFunction(onComplete: null)
/// ```
///
/// The parameters can be anything at all
///
/// - SeeAlso: ``blackhole(_:)`` for a version that's NEVER optimized-out
@inline(__always)
@Sendable
public func null<each Ignored>(_: repeat each Ignored) { }
