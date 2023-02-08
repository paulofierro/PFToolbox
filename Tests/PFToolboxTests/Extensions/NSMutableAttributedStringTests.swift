//
//   NSMutableAttributedStringTests.swift
//   Copyright © 2023 Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import SwiftUI
import XCTest

final class NSMutableAttributedStringTests: XCTestCase {
    func testAddingAttributes() throws {
        let text = "This is my string"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Color(.red),
            .font: Font.system(size: 12)
        ]

        // Create an attributed string with the attributes
        let stringA = NSAttributedString(
            string: text,
            attributes: attributes
        )

        // Create an attributed string without the attributes, and then
        // use our helper to apply them to the entire string.
        let stringB = NSMutableAttributedString(string: text)
        stringB.addAttributes(attributes)

        XCTAssertEqual(stringA, stringB)
    }
}
