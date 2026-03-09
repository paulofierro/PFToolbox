//
//   HTTPHeaders.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import Testing

struct HTTPHeadersTests {
    @Test func equality() {
        #expect(HTTPHeaderValue.jsonContent.rawValue == "application/json")
        #expect(HTTPHeaderValue.basicAuthorization(token: "XYZ").rawValue == "Basic XYZ")
        #expect(HTTPHeaderValue.bearer(token: "XYZ").rawValue == "Bearer XYZ")
        #expect(HTTPHeaderValue.safariUserAgent.rawValue == "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Safari/605.1.15")
        #expect(HTTPHeaderValue.noCache.rawValue == "no-cache")
        #expect(HTTPHeaderValue.gzipEncoding.rawValue == "gzip")
        #expect(HTTPHeaderValue.generic(string: "Something").rawValue == "Something")
    }
}
