//
//   EncodableTests.swift
//   Copyright © 2022 Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

final class EncodableTests: XCTestCase {
    struct MyStruct: Encodable {
        let name: String
    }

    func testJSONEncoding() throws {
        let value = MyStruct(name: "Paulo")
        let json = try value.toJSON()
        XCTAssertEqual(json, """
        {
          "name" : "Paulo"
        }
        """)
    }
}
