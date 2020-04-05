//
//  Blackholes.swift
//  FunctionTools
//
//  Created by Ben Leggiero on 2020-04-02.
//  Copyright © 2020 Ben Leggiero BS-1-PS.
//

import Foundation



/// This guarantees that even the most scrutinous of optimizers will never optimize-away these blackholes
private var blackholeAcceptor: Any? {
    didSet {
        blackholeAcceptor = nil
    }
}


/// A function which does nothing, but will never be optimized away. Useful for testing.
@inline(never)
public func blackhole() -> Void { }


/// A function which takes one value and does nothing with it, but will never be optimized away. Useful for testing.
///
/// For example:
/// ```swift
/// stuff.forEach(blackhole)
/// ```
///
/// - Parameter a: Anything at all
@inline(never)
public func blackhole<A>(_ a: A) -> Void { blackholeAcceptor = a }


/// A function which takes two values and does nothing with them, but will never be optimized away. Useful for testing.
///
/// - Parameters:
///     - a: Anything at all
///     - b: Anything at all
@inline(never)
public func blackhole<A, B>(_ a: A, _ b: B) -> Void { blackholeAcceptor = (a, b) }


/// A function which takes three values and does nothing with them, but will never be optimized away. Useful for testing.
///
/// - Parameters:
///     - a: Anything at all
///     - b: Anything at all
///     - c: Anything at all
@inline(never)
public func blackhole<A, B, C>(_ a: A, _ b: B, _ c: C) -> Void { blackholeAcceptor = (a, b, c) }


/// A function which takes four values and does nothing with them, but will never be optimized away. Useful for testing.
///
/// - Parameters:
///     - a: Anything at all
///     - b: Anything at all
///     - c: Anything at all
///     - d: Anything at all
@inline(never)
public func blackhole<A, B, C, D>(_ a: A, _ b: B, _ c: C, _ d: D) -> Void { blackholeAcceptor = (a, b, c, d) }


/// A function which takes five values and does nothing with them, but will never be optimized away. Useful for testing.
///
/// - Parameters:
///     - a: Anything at all
///     - b: Anything at all
///     - c: Anything at all
///     - d: Anything at all
///     - e: Anything at all     
@inline(never)
public func blackhole<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E) -> Void { blackholeAcceptor = (a, b, c, d, e) }
