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
/// - SeeAlso: `blackhole`
@inline(__always)
public func null() { }


/// A function which takes one value and does nothing with it, and will always be optimized away. Useful for when
/// another function needs to take a callback but you have nothing to do when it calls it.
///
/// For example:
/// ```swift
/// myObject.someAsyncFunction(onComplete: null)
/// ```
///
/// - Parameter a: Anything at all
///
/// - SeeAlso: `blackhole`
@inline(__always)
public func null<A>(_ a: A) { }


/// A function which takes two values and does nothing with them, and will always be optimized away. Useful for when
/// another function needs to take a callback but you have nothing to do when it calls it.
///
/// - Parameters:
///     - a: Anything at all
///     - b: Anything at all
///
/// - SeeAlso: `blackhole`
@inline(__always)
public func null<A, B>(_ a: A, _ b: B) { }


/// A function which takes three values and does nothing with them, and will always be optimized away. Useful for when
/// another function needs to take a callback but you have nothing to do when it calls it.
///
/// - Parameters:
///     - a: Anything at all
///     - b: Anything at all
///     - c: Anything at all
///
/// - SeeAlso: `blackhole`
@inline(__always)
public func null<A, B, C>(_ a: A, _ b: B, _ c: C) { }


/// A function which takes four values and does nothing with them, and will always be optimized away. Useful for when
/// another function needs to take a callback but you have nothing to do when it calls it.
///
/// - Parameters:
///     - a: Anything at all
///     - b: Anything at all
///     - c: Anything at all
///     - d: Anything at all
///
/// - SeeAlso: `blackhole`
@inline(__always)
public func null<A, B, C, D>(_ a: A, _ b: B, _ c: C, _ d: D) { }


/// A function which takes five values and does nothing with them, and will always be optimized away. Useful for when
/// another function needs to take a callback but you have nothing to do when it calls it.
///
/// - Parameters:
///     - a: Anything at all
///     - b: Anything at all
///     - c: Anything at all
///     - d: Anything at all
///     - e: Anything at all
///
/// - SeeAlso: `blackhole`
@inline(__always)
public func null<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E) { }

