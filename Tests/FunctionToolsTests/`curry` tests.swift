//
//  curry Tests.swift
//  
//
//  Created by The Northstar✨ System on 2023-10-04.
//

import XCTest

import FunctionTools



final class curry_Tests: XCTestCase {

    func test_curry() throws {
        let add: (Int) -> (Int) -> Int = curry(+)
        
        XCTAssertEqual(
            [1, 2, 3, 4].map(add(4)),
            [5, 6, 7, 8]
        )
    }
}
