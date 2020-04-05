//
//  Function types.swift
//  FunctionTools
//
//  Created by Ben Leggiero on 2020-04-02.
//  Copyright © 2020 Ben Leggiero BS-1-PS.
//

import Foundation



// MARK: - Callbacks

/// A function that you'd pass to another one as a callback, which doesn't need to know anything nor report anything
public typealias BlindCallback = () -> Void



/// A function that you'd pass to another one as a callback, which doesn't need to know anything nor report anything.
/// It can also throw an error if necessary.
///
/// - Throws: Some error, if a problem occurred while provessing the callback
public typealias ThrowingBlindCallback = () throws -> Void



/// A function that you'd pass to another one as a callback, which needs to know the result of the other one
///
/// - Parameter result: The result of the function that this one is passed to
public typealias Callback<Result> = (_ result: Result) -> Void



/// A function that you'd pass to another one as a callback, which needs to know the result of the other one. It can
/// also throw an error if necessary.
///
/// - Parameter result: The result of the function that this one is passed to
/// - Throws: Some error, if a problem occurred while provessing the callback
public typealias ThrowingCallback<Result> = (_ result: Result) throws -> Void



// MARK: - Transformer family

/// A function which can transform one thing into another, like the kind you pass to a `map` function
///
/// - Parameter original: The value before transformation
/// - Returns: The value after transformation
public typealias Transformer<Original, Transformed> = (_ original: Original) -> Transformed



/// A function which can transform one thing into another, like the kind you pass to a `map` function. It can also
/// throw an error if necessary.
///
/// - Parameter original: The value before transformation
/// - Returns: The value after transformation
/// - Throws: Some error, if a problem occurred during transformation
public typealias ThrowingTransformer<Original, Transformed> = (_ original: Original) throws -> Transformed



/// A function which can filter a sequence of elements, like the kind you pass to a `filter` function
///
/// - Parameter original: Each element in a sequence
/// - Returns: `true` iff the given element should be in the filtered view of the sequence
public typealias Filter<Element> = Transformer<Element, Bool>



/// A function which can filter a sequence of elements, like the kind you pass to a `filter` function. It can also
/// throw an error if necessary.
///
/// - Parameter original: Each element in a sequence
/// - Returns: `true` iff the given element should be in the filtered view of the sequence
/// - Throws: Some error, if a problem occurred during filtering
public typealias ThrowingFilter<Element> = ThrowingTransformer<Element, Bool>



// MARK: - Reducer family

/// A function which can reduce a sequence of elements into one value, like the kind you pass to a `reduce` function
///
/// - Parameters
///     - reduction: The result of reducing the sequence
///     - element: Each element in a sequence
public typealias Reducer<Collection, Reduction> = (_ reduction: inout Reduction, _ element: Collection.Element) -> Void
    where Collection: Swift.Sequence




/// A function which can reduce a sequence of elements into one value, like the kind you pass to a `reduce` function.
/// It can also throw an error if necessary.
///
/// - Parameters
///     - reduction: The result of reducing the sequence
///     - element: Each element in a sequence
///
/// - Throws: Some error, if a problem occurred during reducing
public typealias ThrowingReducer<Collection, Reduction> = (_ reduction: inout Reduction, _ element: Collection.Element) throws -> Void
    where Collection: Swift.Sequence



/// A function which can reduce a sequence of elements into one value by allocating new reductions, like the kind you
/// pass to a `reduce` function. Often slower than `Reducer`.
///
/// - Parameters
///     - reduction: The result of reducing the sequence before this function was called
///     - element: Each element in a sequence
///
/// - Returns: The result of reducing the sequence with the current element
public typealias AllocationReducer<Collection, Reduction> = (_ reduction: Reduction, _ element: Collection.Element) -> Reduction
    where Collection: Swift.Sequence




/// A function which can reduce a sequence of elements into one value by allocating new reductions, like the kind you
/// pass to a `reduce` function. It can also throw an error if necessary. Often slower than `ThrowingReducer`.
///
/// - Parameters
///     - reduction: The result of reducing the sequence before this function was called
///     - element: Each element in a sequence
///
/// - Returns: The result of reducing the sequence with the current element
///
/// - Throws: Some error, if a problem occurred during reducing
public typealias ThrowingAllocationReducer<Collection, Reduction> = (_ reduction: Reduction, _ element: Collection.Element) throws -> Reduction
    where Collection: Swift.Sequence



// MARK: - Combinator family

/// A function which can combine two values into one
///
/// - Parameters:
///    - a: Any initial input
///    - b: Any second input
///
/// - Returns: The result of combining the two inputs
public typealias Combinator<InputA, InputB, Output> = (_ a: InputA, _ b: InputB) -> Output



/// A function which can combine two values into one. It can also throw an error if necessary.
///
/// - Parameters:
///    - a: Any initial input
///    - b: Any second input
///
/// - Returns: The result of combining the two inputs
///
/// - Throws: Some error, if a problem occurred during combination
public typealias ThrowingCombinator<InputA, InputB, Output> = (_ a: InputA, _ b: InputB) throws -> Output



// MARK: Higher-Order

/// A function which can combine two values into one, over the course of multiple separate function calls.
///
/// The return value of a general `curry` function
///
/// - Parameter a: The initial value
/// - Returns: A function which can take a second value, combine it with `a`, and produce a result
public typealias CurriedCombinator<A, B, C> = Transformer<A, Transformer<B, C>>
