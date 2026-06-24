//
//  Blackholes.swift
//  FunctionTools
//
//  Created by Ben Leggiero on 2020-04-02.
//  Copyright © 2020 Ben Leggiero BS-1-PS.
//



/// A function which does nothing, but will never be optimized away. Useful for testing.
///
/// - SeeAlso: ``null(_:)`` for a version that's always optimized-out
@inline(never)
@Sendable
public func blackhole() -> Void { }


/// A function which takes one value and does nothing with it, but will never be optimized away. Useful for testing.
///
/// For example:
/// ```swift
/// stuff.forEach(blackhole)
/// ```
///
/// ```
/// struct MySwiftUIView_Previews: PreviewProvider {
///     static var previews: some View {
///         Group {
///             MySwiftUIView(callback: blackhole)
///         }
///     }
/// }
/// ```
///
/// The parameters can be anything at all
///
/// - SeeAlso: ``null(_:)`` for a version that's ALWAYS optimized-out
@inline(never)
@Sendable
public func blackhole<each Ignored>(_: repeat each Ignored) -> Void { }
