//
//   HTTPURLResponseTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation
@testable import PFToolbox
import Testing

struct HTTPURLResponseTests {
    let url = URL.from(string: "http://paulofierro.com")

    @Test func `valid status code`() {
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        #expect(response?.statusCodeError == nil)
    }

    @Test func `not found status code`() {
        let response = HTTPURLResponse(url: url, statusCode: 404, httpVersion: nil, headerFields: nil)
        #expect(response?.statusCodeError == NetworkError.notFound(404))
    }

    @Test func `authentication status code`() {
        let response = HTTPURLResponse(url: url, statusCode: 403, httpVersion: nil, headerFields: nil)
        #expect(response?.statusCodeError == NetworkError.authenticationError(403))
    }

    @Test func `bad request status code`() {
        let response = HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: nil)
        #expect(response?.statusCodeError == NetworkError.serverError(500))
    }

    @Test func `outdated status code`() {
        let response = HTTPURLResponse(url: url, statusCode: 600, httpVersion: nil, headerFields: nil)
        #expect(response?.statusCodeError == NetworkError.outdated(600))
    }

    @Test func `bad response status code`() {
        let response = HTTPURLResponse(url: url, statusCode: 0, httpVersion: nil, headerFields: nil)
        #expect(response?.statusCodeError == NetworkError.badResponse(0))
    }
}
