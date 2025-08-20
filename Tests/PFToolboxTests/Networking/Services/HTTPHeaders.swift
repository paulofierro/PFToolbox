//
//   HTTPHeaders.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

final class HTTPHeadersTests: XCTestCase {
    func testEquality() throws {
        XCTAssertEqual(HTTPHeaderValue.jsonContent.rawValue, "application/json")
        XCTAssertEqual(HTTPHeaderValue.basicAuthorization(token: "XYZ").rawValue, "Basic XYZ")
        XCTAssertEqual(HTTPHeaderValue.bearer(token: "XYZ").rawValue, "Bearer XYZ")
        XCTAssertEqual(HTTPHeaderValue.safariUserAgent.rawValue, "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Safari/605.1.15")
        XCTAssertEqual(HTTPHeaderValue.noCache.rawValue, "no-cache")
        XCTAssertEqual(HTTPHeaderValue.gzipEncoding.rawValue, "gzip")
        XCTAssertEqual(HTTPHeaderValue.generic(string: "Something").rawValue, "Something")
    }
}
