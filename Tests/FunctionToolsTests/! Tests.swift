//
//  ! Tests.swift
//  FunctionTools
//
//  Created by Ben Leggiero on 2020-06-21.
//  Copyright © 2020 Ben Leggiero BS-1-PS.
//

import XCTest
import FunctionTools

final class ExclamationPoint_Tests: XCTestCase {
    func testExclamationPoint() {
        func myFilter(_ text: String) -> Bool {
            text.hasSuffix("Leggiero")
        }
        
        
        let array = [
            "Johnny Appleseed",
            "Joe Schmo",
            "Ben Leggiero",
            "John Doe",
        ]
        
        
        XCTAssertEqual(array.filter(myFilter), [
            "Ben Leggiero",
        ])
        
        XCTAssertEqual(array.filter(!myFilter), [
            "Johnny Appleseed",
            "Joe Schmo",
            "John Doe",
        ])
    }
    
    static var allTests = [
        ("testExclamationPoint", testExclamationPoint),
    ]
}

