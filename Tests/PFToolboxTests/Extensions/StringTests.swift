//
//   StringTests.swift
//   Copyright © 2023 Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

final class StringTests: XCTestCase {
    func testBoolValues() throws {
        let trueValue = "true"
        let yesValue = "yes"
        let oneValue = "1"
        let otherValue = "other"

        XCTAssertTrue(trueValue.boolValue)
        XCTAssertTrue(yesValue.boolValue)
        XCTAssertTrue(oneValue.boolValue)
        XCTAssertFalse(otherValue.boolValue)
    }

    func testOptionalBoolValues() throws {
        let trueValue: String?
        let yesValue: String?
        let oneValue: String?
        let otherValue: String?
        let nilValue: String? = nil

        trueValue = "true"
        yesValue = "yes"
        oneValue = "1"
        otherValue = "other"

        XCTAssertTrue(trueValue.boolValue)
        XCTAssertTrue(yesValue.boolValue)
        XCTAssertTrue(oneValue.boolValue)
        XCTAssertFalse(otherValue.boolValue)
        XCTAssertFalse(nilValue.boolValue)
    }

    func testValidEmails() {
        let addresses: [String] = [
            "paulo@paulofierro.com",
            "paulo+test@paulofierro.com",
            "12345@paulofierro.com",
            "12345@paulofierro.co.uk",
            "12345@paulofierro.ky"
        ]
        for address in addresses {
            XCTAssertTrue(address.isValidEmailAddress)
        }
    }

    func testInvalidEmails() {
        let addresses: [String] = [
            "paulo.fierro?paulofierro.com",
            "",
            "12345@paulofierro",
            "http://paulofierro.com",
            "user:pass@paulofierro.com"
        ]
        for address in addresses {
            XCTAssertFalse(address.isValidEmailAddress)
        }
    }

    func testTrim() {
        let originalString = "This is a string"
        let string = "This is a string"
        let stringWithEndSpaces = "This is a string      "
        let stringWithSpaces = "       This is a string      "
        let stringWithNewlines = """
            This is a string

        """
        XCTAssertEqual(string.trim(), originalString)
        XCTAssertEqual(stringWithEndSpaces.trim(), originalString)
        XCTAssertEqual(stringWithSpaces.trim(), originalString)
        XCTAssertEqual(stringWithNewlines.trim(), originalString)
    }

    func testSubscript() {
        let string = "Hi"
        XCTAssertEqual(string[0], "H")
        XCTAssertEqual(string[1], "i")

        // Test safe accessing
        XCTAssertEqual(string[safeIndex: 0], "H")
        XCTAssertEqual(string[safeIndex: 1], "i")
        XCTAssertNil(string[safeIndex: 2]) // Yay, nil!
    }

    func testPercentEscapingInvalidString() throws {
        let bytes: [UInt8] = [0xD8, 0x00]
        let invalidString = try XCTUnwrap(String(
            bytes: bytes,
            encoding: .utf16BigEndian
        ))
        XCTAssertEqual(invalidString, invalidString.percentEscapeString())
    }

    func testPercentEscapingString() {
        var string = "a_b.c*d"
        XCTAssertEqual(string, string.percentEscapeString())

        string = "Hello World!"
        XCTAssertEqual("Hello+World%21", string.percentEscapeString())

        string = "paulo@paulofierro.com"
        XCTAssertEqual("paulo%40paulofierro.com", string.percentEscapeString())
    }

    func testSavingToDisk() throws {
        let string = "hello world"
        let url = try string.saveToDisk(path: "/tmp/test")
        XCTAssertTrue(FileManager.default.fileExists(atPath: url.path))

        let data = try XCTUnwrap(FileManager.default.contents(atPath: url.path))
        let readString = try XCTUnwrap(String(data: data, encoding: .utf8))
        XCTAssertEqual(string, readString)
    }
}
