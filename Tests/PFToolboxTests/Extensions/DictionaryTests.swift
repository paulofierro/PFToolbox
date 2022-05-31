//
//  DictionaryTests.swift
//  
//
//  Created by Paulo Fierro.
//

import XCTest
@testable import PFToolbox

final class DictionaryTests: XCTestCase {
    
    func testMerging() async throws {
        var one = ["a": 1, "b": 2]
        let two = ["c": 3]
        one.merge(dict: two)
        XCTAssertEqual(one["a"], 1)
        XCTAssertEqual(one["b"], 2)
        XCTAssertEqual(one["c"], 3)
    }
    
    func testMergingOverwrite() async throws {
        var one = ["a": 1, "b": 2]
        let two = ["b": 3]
        one.merge(dict: two)
        XCTAssertEqual(one["a"], 1)
        XCTAssertEqual(one["b"], 3)
    }
}
