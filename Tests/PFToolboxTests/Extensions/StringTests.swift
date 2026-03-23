//
//   StringTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation
@testable import PFToolbox
import Testing

struct StringTests {
    @Test func boolValues() {
        let trueValue = "true"
        let yesValue = "yes"
        let oneValue = "1"
        let otherValue = "other"

        #expect(trueValue.boolValue)
        #expect(yesValue.boolValue)
        #expect(oneValue.boolValue)
        #expect(!otherValue.boolValue)
    }

    @Test func optionalBoolValues() {
        let trueValue: String?
        let yesValue: String?
        let oneValue: String?
        let otherValue: String?
        let nilValue: String? = nil

        trueValue = "true"
        yesValue = "yes"
        oneValue = "1"
        otherValue = "other"

        #expect(trueValue.boolValue)
        #expect(yesValue.boolValue)
        #expect(oneValue.boolValue)
        #expect(!otherValue.boolValue)
        #expect(!nilValue.boolValue)
    }

    @Test func validEmails() {
        let addresses: [String] = [
            "paulo@paulofierro.com",
            "paulo+test@paulofierro.com",
            "12345@paulofierro.com",
            "12345@paulofierro.co.uk",
            "12345@paulofierro.ky"
        ]
        for address in addresses {
            #expect(address.isValidEmailAddress)
        }
    }

    @Test func invalidEmails() {
        let addresses: [String] = [
            "paulo.fierro?paulofierro.com",
            "",
            "12345@paulofierro",
            "http://paulofierro.com",
            "user:pass@paulofierro.com"
        ]
        for address in addresses {
            #expect(!address.isValidEmailAddress)
        }
    }

    @Test func trim() {
        let originalString = "This is a string"
        let string = "This is a string"
        let stringWithEndSpaces = "This is a string      "
        let stringWithSpaces = "       This is a string      "
        let stringWithNewlines = """
            This is a string

        """
        #expect(string.trim() == originalString)
        #expect(stringWithEndSpaces.trim() == originalString)
        #expect(stringWithSpaces.trim() == originalString)
        #expect(stringWithNewlines.trim() == originalString)
    }

    @Test func subscriptAccess() {
        let string = "Hi"
        #expect(string[0] == "H")
        #expect(string[1] == "i")

        // Test safe accessing
        #expect(string[safeIndex: -1] == nil)
        #expect(string[safeIndex: 0] == "H")
        #expect(string[safeIndex: 1] == "i")
        #expect(string[safeIndex: 2] == nil) // Yay, nil!
    }

    @Test func percentEscapingString() {
        var string = "a_b.c*d"
        #expect(string == string.percentEscapeString())

        string = "Hello World!"
        #expect(string.percentEscapeString() == "Hello+World%21")

        string = "paulo@paulofierro.com"
        #expect(string.percentEscapeString() == "paulo%40paulofierro.com")
    }

    @Test func savingToDisk() throws {
        let string = "hello world"
        let url = try string.saveToDisk(path: "/tmp/test")
        #expect(FileManager.default.fileExists(atPath: url.path))

        let data = try #require(FileManager.default.contents(atPath: url.path))
        let readString = try #require(String(data: data, encoding: .utf8))
        #expect(string == readString)
    }
}
