//
//   DictionaryTests.swift
//   Copyright © 2022 Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

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

    func testMergingNil() async throws {
        var one = ["a": 1, "b": 2]
        one.merge(dict: nil)
        XCTAssertEqual(one["a"], 1)
        XCTAssertEqual(one["b"], 2)
    }
}
