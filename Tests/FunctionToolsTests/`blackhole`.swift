//
//  blackhole tests.swift
//  FunctionTools
//
//  Created by Ky on 2026-06-23.
//

import Testing

import FunctionTools



@Suite("`blackhole` tests")
struct blackhole_Test {
    
    @Test("`blackhole` handles 1 parameters")
    func blackhole_1parameters() async throws {
        let (a) = (1)
        blackhole(a)
        #expect((1) == (a))
    }
    
    
    @Test("`blackhole` handles 2 parameters")
    func blackhole_2parameters() async throws {
        let (a, b) = (1, "2")
        blackhole(a, b)
        #expect((1, "2") == (a, b))
    }
    
    
    @Test("`blackhole` handles 3 parameters")
    func blackhole_3parameters() async throws {
        let (a, b, c) = (1, "2", 3.4)
        blackhole(a, b, c)
        #expect((1, "2", 3.4) == (a, b, c))
    }
    
    
    @Test("`blackhole` handles 4 parameters")
    func blackhole_4parameters() async throws {
        let (a, b, c, d) = (1, "2", 3.4, true)
        blackhole(a, b, c, d)
        #expect((1, "2", 3.4, true) == (a, b, c, d))
    }
    
    
    @Test("`blackhole` handles 5 parameters")
    func blackhole_5parameters() async throws {
        let (a, b, c, d, e) = (1, "2", 3.4, true, uuid)
        blackhole(a, b, c, d, e)
        #expect((1, "2", 3.4, true, uuid) == (a, b, c, d, e))
    }
    
    
    @Test("`blackhole` handles 6 parameters")
    func blackhole_6parameters() async throws {
        let (a, b, c, d, e, f) = (1, "2", 3.4, true, uuid, #function)
        blackhole(a, b, c, d, e, f)
        #expect((1, "2", 3.4, true, uuid, #function) == (a, b, c, d, e, f))
    }
    
    
    @Test("`blackhole` handles 7 parameters")
    func blackhole_7parameters() async throws {
        let (a, b, c, d, e, f, g) = (1, "2", 3.4, true, uuid, #function, [1, 2, 3])
        blackhole(a, b, c, d, e, f, g)
        #expect((1, "2", 3.4, true, uuid, #function) == (a, b, c, d, e, f))
        #expect([1, 2, 3] == g) // Blackhole now handles arbitrary parameter counts, but `==` only handles tuples up to 6 items wide – Ky, 2026-06-23
    }
}
