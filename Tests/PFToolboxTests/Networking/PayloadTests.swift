//
//   PayloadTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import Testing

struct PayloadTests {
    struct UnencodablePayload: Payload {
        let name: String

        func encode(to encoder: Encoder) throws {
            throw EncodingError.encodingFailed
        }
    }

    @Test func failedEncode() {
        let payload = UnencodablePayload(name: "")
        #expect(payload.toJSON() == nil)
        #expect(payload["name"] == nil)
    }

    struct TestPayload: Payload {
        let id: String
    }

    @Test func subscriptAccess() throws {
        let test = TestPayload(id: "123")
        #expect(try #require(test["id"] as? String) == "123")
    }
}
