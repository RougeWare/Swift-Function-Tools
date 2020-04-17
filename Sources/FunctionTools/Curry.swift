//
//  Curry.swift
//  FunctionTools
//
//  Created by Ben Leggiero on 2020-04-02.
//  Copyright © 2020 Ben Leggiero BS-1-PS.
//

import Foundation



/// Converts a non-currying function into a currying function
///
/// ```swift
/// let add = curry(+)
/// [1, 2, 3, 4].map(add(4)) // [5, 6, 7, 8]
/// ```
///
/// - Parameter f: The function to convert
/// - Returns: A currying form of the given function
func curry<A, B, C>(_ f: @escaping Combinator<A, B, C>) -> Transformer<A, Transformer<B, C>> {
    return { a in { b in f(a, b) } }
}
