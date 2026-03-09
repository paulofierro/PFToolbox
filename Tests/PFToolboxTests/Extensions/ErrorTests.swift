//
//   ErrorTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

final class ErrorTests: XCTestCase {
    let url = URL.from(string: "http://paulofierro.com")

    func testComparingDecodingError() {
        XCTAssertEqual(DecodingError.fileNotFound("abc.json"), DecodingError.fileNotFound("abc.json"))
    }

    func testComparingEncodingError() {
        XCTAssertEqual(EncodingError.noData, EncodingError.noData)
        XCTAssertNotEqual(EncodingError.noData, EncodingError.encodingFailed)
    }
}
