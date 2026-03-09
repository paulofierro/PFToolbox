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

    @Test func creatingFromString() {
        let value = StringEnum.from("two")
        #expect(value == StringEnum.two)
    }

    @Test func creatingFromInt() {
        let value = IntEnum.from(1)
        #expect(value == IntEnum.two)
    }

    @Test func nilDefaultValue() {
        #expect(StringEnum.from(nil) == StringEnum.one)
        #expect(IntEnum.from(nil) == IntEnum.one)
    }

    @Test func emptyDefaultValue() {
        #expect(StringEnum.from("") == StringEnum.one)
        #expect(IntEnum.from(nil) == IntEnum.one)
    }

    @Test func optionalDefaultValue() {
        let value: String? = ""
        #expect(StringEnum.from(value) == StringEnum.one)
        #expect(IntEnum.from(nil) == IntEnum.one)
    }
}
