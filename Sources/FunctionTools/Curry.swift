//
//  Curry.swift
//  FunctionTools
//
//  Created by Ben Leggiero on 2020-04-02.
//  Copyright © 2020 Ben Leggiero BS-1-PS.
//

import Foundation



/// The type of function returned by ``curry(_:)``
public typealias Curry<A, B, C> = Transformer<A, Transformer<B, C>>



/// Converts a non-currying function into a currying function
///
/// ```swift
/// let add = curry(+)
/// [1, 2, 3, 4].map(add(4)) // [5, 6, 7, 8]
/// ```
///
/// - Parameter f: The function to convert
/// - Returns: A currying form of the given function
public func curry<A, B, C>(_ f: @escaping Combinator<A, B, C>) -> Curry<A, B, C> {
    return { a in { b in f(a, b) } }
}
