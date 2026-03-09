//
//   ArrayTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import Testing

struct ArrayTests {
    @Test func safeIndex() {
        let array = [1, 2, 3]

        #expect(array[0] == 1)
        #expect(array[safeIndex: 0] == 1)

        #expect(array[1] == 2)
        #expect(array[safeIndex: 1] == 2)

        #expect(array[2] == 3)
        #expect(array[safeIndex: 2] == 3)

        // Out of bounds exception
        #expect(array[safeIndex: 3] == nil)
    }
}
