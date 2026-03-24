//
//   ValueConstructableTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import Testing

struct ValueConstructableTests {
    enum StringEnum: String, ValueConstructable {
        case one, two, three

        static func defaultValue() -> Self {
            .one
        }
    }

    enum IntEnum: Int, ValueConstructable {
        case one, two, three

        static func defaultValue() -> Self {
            .one
        }
    }

    @Test func `creating from string`() {
        let value = StringEnum.from("two")
        #expect(value == StringEnum.two)
    }

    @Test func `creating from int`() {
        let value = IntEnum.from(1)
        #expect(value == IntEnum.two)
    }

    @Test func `nil default value`() {
        #expect(StringEnum.from(nil) == StringEnum.one)
        #expect(IntEnum.from(nil) == IntEnum.one)
    }

    @Test func `empty default value`() {
        #expect(StringEnum.from("") == StringEnum.one)
        #expect(IntEnum.from(nil) == IntEnum.one)
    }

    @Test func `optional default value`() {
        let value: String? = ""
        #expect(StringEnum.from(value) == StringEnum.one)
        #expect(IntEnum.from(nil) == IntEnum.one)
    }
}
