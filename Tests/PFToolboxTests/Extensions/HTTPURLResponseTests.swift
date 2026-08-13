//
//   HTTPURLResponseTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
@testable import PFToolbox
import Testing

struct HTTPURLResponseTests {
    let url = URL.from(string: "http://paulofierro.com")

    private func error(for statusCode: Int) -> NetworkError? {
        HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)?
            .statusCodeError
    }

    @Test func `valid status code`() {
        for statusCode in [200, 201, 204, 299] {
            #expect(error(for: statusCode) == nil)
        }
    }

    /// Not Modified is the successful outcome of a conditional request, not a failure
    @Test func `not modified status code`() {
        #expect(error(for: 304) == nil)
    }

    @Test func `not found status code`() {
        #expect(error(for: 404) == NetworkError.notFound(404))
    }

    @Test func `authentication status code`() {
        #expect(error(for: 401) == NetworkError.authenticationError(401))
        #expect(error(for: 403) == NetworkError.authenticationError(403))
    }

    /// Client errors that are not authentication failures must not be reported as such
    @Test func `other client error status codes`() {
        for statusCode in [400, 409, 422, 429] {
            #expect(error(for: statusCode) == NetworkError.failed(statusCode))
        }
    }

    @Test func `server error status code`() {
        #expect(error(for: 500) == NetworkError.serverError(500))
        #expect(error(for: 503) == NetworkError.serverError(503))
    }

    @Test func `outdated status code`() {
        #expect(error(for: 410) == NetworkError.outdated(410))
        #expect(error(for: 426) == NetworkError.outdated(426))
    }

    @Test func `bad response status code`() {
        #expect(error(for: 0) == NetworkError.badResponse(0))
        #expect(error(for: 600) == NetworkError.badResponse(600))
    }
}
