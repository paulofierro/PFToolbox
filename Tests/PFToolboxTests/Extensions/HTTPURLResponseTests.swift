//
//   HTTPURLResponseTests.swift
//   Copyright © 2022 Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

final class HTTPURLResponseTests: XCTestCase {
    let url = URL.from(string: "http://paulofierro.com")

    func testValidStatusCode() throws {
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        XCTAssertNil(response?.statusCodeError)
    }

    func testNotFoundStatusCode() throws {
        let response = HTTPURLResponse(url: url, statusCode: 404, httpVersion: nil, headerFields: nil)
        XCTAssertEqual(response?.statusCodeError, NetworkError.notFound(404))
    }

    func testAuthenticationStatusCode() throws {
        let response = HTTPURLResponse(url: url, statusCode: 403, httpVersion: nil, headerFields: nil)
        XCTAssertEqual(response?.statusCodeError, NetworkError.authenticationError(403))
    }

    func testBadRequestStatusCode() throws {
        let response = HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: nil)
        XCTAssertEqual(response?.statusCodeError, NetworkError.badRequest(500))
    }

    func testOutdatedStatusCode() throws {
        let response = HTTPURLResponse(url: url, statusCode: 600, httpVersion: nil, headerFields: nil)
        XCTAssertEqual(response?.statusCodeError, NetworkError.outdated(600))
    }

    func testBadResponseStatusCode() throws {
        let response = HTTPURLResponse(url: url, statusCode: 0, httpVersion: nil, headerFields: nil)
        XCTAssertEqual(response?.statusCodeError, NetworkError.badResponse(0))
    }
}
