//
//  test utilities.swift
//  FunctionTools
//
//  Created by Ky on 2026-03-24.
//

import Foundation



// MARK: - data structures

/// Thrown by generator fixtures to verify that something propagates failures faithfully
struct TestError: Error, Equatable {}



/// A simple value type used to verify that something does not mutate, copy-construct unexpectedly, or otherwise interfere with custom structs.
struct Point: Equatable {
    let x: Int
    let y: Int
}



/// A reference type used to verify that identity (===) is preserved when something is handed a class instance.
final class Token {}
