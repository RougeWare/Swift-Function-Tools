//
//  !.swift
//  FunctionTools
//
//  Created by Ben Leggiero on 2020-06-21.
//  Copyright © 2020 Ben Leggiero BS-1-PS.
//

import Foundation



/// Inverts the return value of the given function
///
/// - Parameter rhs: The function whose output to flip
/// - Returns: A function which calls the given function and then inverts its output
public prefix func ! <Original> (rhs: @escaping Transformer<Original, Bool>) -> Transformer<Original, Bool> {{
    !rhs($0)
}}
