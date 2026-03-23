//
//   HTTPHeaders.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import Testing

struct HTTPHeadersTests {
    @Test func headerFieldRawValues() {
        #expect(HTTPHeaderField.accept.rawValue == "Accept")
        #expect(HTTPHeaderField.contentType.rawValue == "Content-Type")
        #expect(HTTPHeaderField.userAgent.rawValue == "User-Agent")
        #expect(HTTPHeaderField.authorization.rawValue == "Authorization")
        #expect(HTTPHeaderField.pragma.rawValue == "Pragma")
        #expect(HTTPHeaderField.cacheControl.rawValue == "Cache-Control")
        #expect(HTTPHeaderField.acceptEncoding.rawValue == "Accept-Encoding")
        #expect(HTTPHeaderField.custom("X-Request-Id").rawValue == "X-Request-Id")
    }

    @Test func headerValueRawValues() {
        #expect(HTTPHeaderValue.jsonContent.rawValue == "application/json")
        #expect(HTTPHeaderValue.urlEncodedFormContent.rawValue == "application/x-www-form-urlencoded")
        #expect(HTTPHeaderValue.basicAuthorization(token: "XYZ").rawValue == "Basic XYZ")
        #expect(HTTPHeaderValue.bearer(token: "XYZ").rawValue == "Bearer XYZ")
        #expect(HTTPHeaderValue.safariUserAgent.rawValue == "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Safari/605.1.15")
        #expect(HTTPHeaderValue.noCache.rawValue == "no-cache")
        #expect(HTTPHeaderValue.gzipEncoding.rawValue == "gzip")
        #expect(HTTPHeaderValue.generic(string: "Something").rawValue == "Something")
    }
}
