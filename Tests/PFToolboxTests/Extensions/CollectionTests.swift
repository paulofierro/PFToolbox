//
//   CollectionTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import Testing

struct CollectionTests {
    @Test func `is not empty`() {
        let array = [String]()
        let dict: [String: String] = [:]
        let string = ""

        #expect(array.isEmpty)
        #expect(dict.isEmpty)
        #expect(string.isEmpty)
        #expect(!array.isNotEmpty)
        #expect(!dict.isNotEmpty)
        #expect(!string.isNotEmpty)
    }

    @Test func `optional is not empty`() {
        let array: [String]? = []
        let dict: [String: String]? = [:]
        let string: String? = ""

        #expect(!array.isNotEmpty)
        #expect(!dict.isNotEmpty)
        #expect(!string.isNotEmpty)
    }

    @Test func `optional is empty or nil`() {
        var array: [String]?
        var dict: [String: String]?
        var string: String?

        // Values are nil
        #expect(array.isEmptyOrNil)
        #expect(dict.isEmptyOrNil)
        #expect(string.isEmptyOrNil)

        array = []
        dict = [:]
        string = ""

        // Values are empty
        #expect(array.isEmptyOrNil)
        #expect(dict.isEmptyOrNil)
        #expect(string.isEmptyOrNil)
    }

    @Test func `only contains`() {
        let invalidString = "ABC"
        let validString = "A"
        #expect(!invalidString.onlyContains("A"))
        #expect(validString.onlyContains("A"))

        let invalidArray = ["A", "B", "C"]
        let validArray = ["A"]
        #expect(!invalidArray.onlyContains("A"))
        #expect(validArray.onlyContains("A"))
    }
}
