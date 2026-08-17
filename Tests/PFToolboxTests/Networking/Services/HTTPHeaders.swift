//
//   HTTPHeaders.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
@testable import PFToolbox
import Testing

struct HTTPHeadersTests {
    @Test func `header field raw values`() {
        #expect(HTTPHeaderField.accept.rawValue == "Accept")
        #expect(HTTPHeaderField.contentType.rawValue == "Content-Type")
        #expect(HTTPHeaderField.userAgent.rawValue == "User-Agent")
        #expect(HTTPHeaderField.authorization.rawValue == "Authorization")
        #expect(HTTPHeaderField.pragma.rawValue == "Pragma")
        #expect(HTTPHeaderField.cacheControl.rawValue == "Cache-Control")
        #expect(HTTPHeaderField.acceptEncoding.rawValue == "Accept-Encoding")
        #expect(HTTPHeaderField.custom("X-Request-Id").rawValue == "X-Request-Id")
    }

    @Test func `header value raw values`() {
        #expect(HTTPHeaderValue.jsonContent.rawValue == "application/json")
        #expect(HTTPHeaderValue.urlEncodedFormContent.rawValue == "application/x-www-form-urlencoded")
        #expect(HTTPHeaderValue.basicAuthorization(token: "XYZ").rawValue == "Basic XYZ")
        #expect(HTTPHeaderValue.bearer(token: "XYZ").rawValue == "Bearer XYZ")
        #expect(HTTPHeaderValue.safariUserAgent
            .rawValue ==
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Safari/605.1.15")
        #expect(HTTPHeaderValue.noCache.rawValue == "no-cache")
        #expect(HTTPHeaderValue.gzipEncoding.rawValue == "gzip")
        #expect(HTTPHeaderValue.generic(string: "Something").rawValue == "Something")
    }

    /// A custom field naming a known field must collapse onto it, otherwise the same header
    /// gets added to a request twice.
    @Test func `custom fields collapse onto their canonical case`() {
        #expect(HTTPHeaderField.custom("Accept") == HTTPHeaderField.accept)
        #expect(HTTPHeaderField.custom("Content-Type") == HTTPHeaderField.contentType)

        var headers: HTTPHeaders = [.accept: .jsonContent]
        headers[.custom("Accept")] = .gzipEncoding

        #expect(headers.count == 1)
        #expect(headers[.accept]?.rawValue == HTTPHeaderValue.gzipEncoding.rawValue)
    }

    /// HTTP field names are case-insensitive per RFC 9110
    @Test func `field names are case-insensitive`() {
        #expect(HTTPHeaderField.custom("accept") == HTTPHeaderField.accept)
        #expect(HTTPHeaderField.custom("CONTENT-TYPE") == HTTPHeaderField.contentType)
        #expect(HTTPHeaderField.custom("x-request-id") == HTTPHeaderField.custom("X-Request-Id"))

        var hasher = Hasher()
        hasher.combine(HTTPHeaderField.custom("accept"))
        var otherHasher = Hasher()
        otherHasher.combine(HTTPHeaderField.accept)
        #expect(hasher.finalize() == otherHasher.finalize())
    }

    @Test func `distinct fields stay distinct`() {
        #expect(HTTPHeaderField.accept != HTTPHeaderField.acceptEncoding)
        #expect(HTTPHeaderField.custom("X-One") != HTTPHeaderField.custom("X-Two"))
    }

    /// Naming a field twice under different spellings must not send it twice
    @Test func `request receives one header per field`() {
        var headers: HTTPHeaders = [.accept: .jsonContent]
        headers[.custom("accept")] = .gzipEncoding

        var request = URLRequest(url: URL.from(string: "https://test.com"))
        request.addHeaders(headers)

        #expect(request.allHTTPHeaderFields?.count == 1)
        #expect(request.allHTTPHeaderFields?["Accept"] == HTTPHeaderValue.gzipEncoding.rawValue)
    }
}
