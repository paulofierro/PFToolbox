//
//   ValueConstructableTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

class ValueConstructableTests: XCTestCase {
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

    func testCreatingFromString() {
        let value = StringEnum.from("two")
        XCTAssertEqual(value, StringEnum.two)
    }

    func testCreatingFromInt() {
        let value = IntEnum.from(1)
        XCTAssertEqual(value, IntEnum.two)
    }

    func testNilDefaultValue() {
        XCTAssertEqual(StringEnum.from(nil), StringEnum.one)
        XCTAssertEqual(IntEnum.from(nil), IntEnum.one)
    }

    func testEmptyDefaultValue() {
        XCTAssertEqual(StringEnum.from(""), StringEnum.one)
        XCTAssertEqual(IntEnum.from(nil), IntEnum.one)
    }

    func testOptionalDefaultValue() {
        let value: String? = ""
        XCTAssertEqual(StringEnum.from(value), StringEnum.one)
        XCTAssertEqual(IntEnum.from(nil), IntEnum.one)
    }
}
