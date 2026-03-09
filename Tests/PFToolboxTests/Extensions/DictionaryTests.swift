//
//   DictionaryTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import Testing

struct DictionaryTests {
    @Test func merging() {
        var one = ["a": 1, "b": 2]
        let two = ["c": 3]
        one.merge(dict: two)
        #expect(one["a"] == 1)
        #expect(one["b"] == 2)
        #expect(one["c"] == 3)
    }

    @Test func mergingOverwrite() {
        var one = ["a": 1, "b": 2]
        let two = ["b": 3]
        one.merge(dict: two)
        #expect(one["a"] == 1)
        #expect(one["b"] == 3)
    }

    @Test func mergingNil() {
        var one = ["a": 1, "b": 2]
        one.merge(dict: nil)
        #expect(one["a"] == 1)
        #expect(one["b"] == 2)
    }
}
