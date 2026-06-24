//
//  test utilities.swift
//  FunctionTools
//
//  Created by Ky on 2026-03-24.
//

import Foundation


// MARK: - value transformers

func asyncValue<T: Sendable>(_ value: T) async -> T {
    await Task {
        try? await Task.sleep(for: .milliseconds(.random(in: 0...15)))
        return value
    }
    .value
}



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



// MARK: - values

/// One UUID which is guaranteed to remain the same value per test runtime
let uuid = UUID()

