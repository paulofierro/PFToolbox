//
//   CollectionTests.swift
//   Copyright © 2023 Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

final class CollectionTests: XCTestCase {
    func testIsNotEmpty() {
        let array = [String]()
        let dict: [String: String] = [:]
        let string = ""

        XCTAssertTrue(array.isEmpty)
        XCTAssertTrue(dict.isEmpty)
        XCTAssertTrue(string.isEmpty)
        XCTAssertFalse(array.isNotEmpty)
        XCTAssertFalse(dict.isNotEmpty)
        XCTAssertFalse(string.isNotEmpty)
    }

    func testOptionalIsNotEmpty() {
        let array: [String]? = []
        let dict: [String: String]? = [:]
        let string: String? = ""

        XCTAssertFalse(array.isNotEmpty)
        XCTAssertFalse(dict.isNotEmpty)
        XCTAssertFalse(string.isNotEmpty)
    }

    func testOptionalIsEmptyOrNil() {
        var array: [String]?
        var dict: [String: String]?
        var string: String?

        // Values are nil
        XCTAssertTrue(array.isEmptyOrNil)
        XCTAssertTrue(dict.isEmptyOrNil)
        XCTAssertTrue(string.isEmptyOrNil)

        array = []
        dict = [:]
        string = ""

        // Values are empty
        XCTAssertTrue(array.isEmptyOrNil)
        XCTAssertTrue(dict.isEmptyOrNil)
        XCTAssertTrue(string.isEmptyOrNil)
    }

    func testOnlyContains() {
        let invalidString = "ABC"
        let validString = "A"
        XCTAssertFalse(invalidString.onlyContains("A"))
        XCTAssertTrue(validString.onlyContains("A"))

        let invalidArray = ["A", "B", "C"]
        let validArray = ["A"]
        XCTAssertFalse(invalidArray.onlyContains("A"))
        XCTAssertTrue(validArray.onlyContains("A"))
    }
}
