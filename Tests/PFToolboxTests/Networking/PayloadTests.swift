//
//  PayloadTests.swift
//  
//
//  Created by Paulo Fierro on 31/5/22.
//

@testable import PFToolbox
import XCTest

class PayloadTests: XCTestCase {

    struct UnencodablePayload: Payload {
        let name: String

        func encode(to encoder: Encoder) throws {
            throw EncodingError.encodingFailed
        }
    }

    func testFailedEncode() {
        let payload = UnencodablePayload(name: "")
        XCTAssertNil(payload.toJSON())
    }
}
