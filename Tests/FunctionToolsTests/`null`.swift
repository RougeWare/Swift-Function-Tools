//
//  null tests.swift
//  FunctionTools
//
//  Created by Ky on 2026-06-23.
//

import Testing

import FunctionTools



@Suite("`null` tests")
struct null_Test {
    
    @Test("`null` handles 1 parameters")
    func null_1parameters() async throws {
        let (a) = (1)
        null(a)
        #expect((1) == (a))
    }
    
    
    @Test("`null` handles 2 parameters")
    func null_2parameters() async throws {
        let (a, b) = (1, "2")
        null(a, b)
        #expect((1, "2") == (a, b))
    }
    
    
    @Test("`null` handles 3 parameters")
    func null_3parameters() async throws {
        let (a, b, c) = (1, "2", 3.4)
        null(a, b, c)
        #expect((1, "2", 3.4) == (a, b, c))
    }
    
    
    @Test("`null` handles 4 parameters")
    func null_4parameters() async throws {
        let (a, b, c, d) = (1, "2", 3.4, true)
        null(a, b, c, d)
        #expect((1, "2", 3.4, true) == (a, b, c, d))
    }
    
    
    @Test("`null` handles 5 parameters")
    func null_5parameters() async throws {
        let (a, b, c, d, e) = (1, "2", 3.4, true, uuid)
        null(a, b, c, d, e)
        #expect((1, "2", 3.4, true, uuid) == (a, b, c, d, e))
    }
    
    
    @Test("`null` handles 6 parameters")
    func null_6parameters() async throws {
        let (a, b, c, d, e, f) = (1, "2", 3.4, true, uuid, #function)
        null(a, b, c, d, e, f)
        #expect((1, "2", 3.4, true, uuid, #function) == (a, b, c, d, e, f))
    }
    
    
    @Test("`null` handles 7 parameters")
    func null_7parameters() async throws {
        let (a, b, c, d, e, f, g) = (1, "2", 3.4, true, uuid, #function, [1, 2, 3])
        null(a, b, c, d, e, f, g)
        #expect((1, "2", 3.4, true, uuid, #function) == (a, b, c, d, e, f))
        #expect([1, 2, 3] == g) // Blackhole now handles arbitrary parameter counts, but `==` only handles tuples up to 6 items wide – Ky, 2026-06-23
    }
}
