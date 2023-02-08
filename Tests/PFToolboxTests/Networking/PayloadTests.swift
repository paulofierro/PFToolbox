//
//   PayloadTests.swift
//   Copyright © 2023 Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

final class PayloadTests: XCTestCase {
    struct UnencodablePayload: Payload {
        let name: String

        func encode(to encoder: Encoder) throws {
            throw EncodingError.encodingFailed
        }
    }

    func testFailedEncode() {
        let payload = UnencodablePayload(name: "")
        XCTAssertNil(payload.toJSON())
        XCTAssertNil(payload["name"])
    }

    struct TestPayload: Payload {
        let id: String
    }

    func testSubscript() throws {
        let test = TestPayload(id: "123")
        XCTAssertEqual(try XCTUnwrap(test["id"] as? String), "123")
    }
}
