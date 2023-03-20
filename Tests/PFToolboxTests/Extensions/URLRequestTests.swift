//
//   URLRequestTests.swift
//   Copyright © 2023 Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

final class URLRequestTests: XCTestCase {
    private let url = URL.from(string: "https://paulofierro.com")

    func testAddingHeaderArray() throws {
        // No headers
        var request = URLRequest(url: url)
        XCTAssertNil(request.allHTTPHeaderFields)

        // Add nothing
        request.addHeaders(nil)
        XCTAssertNil(request.allHTTPHeaderFields)

        // Add header
        let value = "something"
        let headers: HTTPHeaders = [.contentType: .generic(string: value)]
        request.addHeaders(headers)

        // Test its presence
        XCTAssertNotNil(request.allHTTPHeaderFields)
        let header = try XCTUnwrap(request.allHTTPHeaderFields?[HTTPHeaderField.contentType.rawValue])
        // Test its contents
        XCTAssertEqual(header, value)
    }

    func testAddingDefinedHeader() throws {
        // No headers
        var request = URLRequest(url: url)
        XCTAssertNil(request.allHTTPHeaderFields)

        request.addValue(.jsonContent, for: .contentType)
        XCTAssertNotNil(request.allHTTPHeaderFields)

        // Test its presence
        XCTAssertNotNil(request.allHTTPHeaderFields)
        let header = try XCTUnwrap(request.allHTTPHeaderFields?[HTTPHeaderField.contentType.rawValue])
        // Test its contents
        XCTAssertEqual(header, HTTPHeaderValue.jsonContent.rawValue)
    }

    func testAddingStringHeader() throws {
        // No headers
        var request = URLRequest(url: url)
        XCTAssertNil(request.allHTTPHeaderFields)

        request.addValue(HTTPHeaderValue.jsonContent.rawValue, for: .contentType)
        XCTAssertNotNil(request.allHTTPHeaderFields)

        // Test its presence
        XCTAssertNotNil(request.allHTTPHeaderFields)
        let header = try XCTUnwrap(request.allHTTPHeaderFields?[HTTPHeaderField.contentType.rawValue])
        // Test its contents
        XCTAssertEqual(header, HTTPHeaderValue.jsonContent.rawValue)
    }

    func testUploadMethods() {
        let uploadMethods: [HTTPMethod] = [.post, .put, .patch]
        let downloadMethods: [HTTPMethod] = [.get, .delete]

        uploadMethods.forEach {
            XCTAssertTrue($0.isUploadMethod)
        }

        downloadMethods.forEach {
            XCTAssertFalse($0.isUploadMethod)
        }
    }

    func testAddingJSONPayload() throws {
        // No payload
        var request = URLRequest(url: url)
        XCTAssertNil(request.httpBody)

        let params: JSON = ["a": "1"]

        // Add params
        try? request.addJSONPayload(params)
        XCTAssertNotNil(request.httpBody)

        // Test the presence of the right header
        XCTAssertNotNil(request.allHTTPHeaderFields)
        let header = try XCTUnwrap(request.allHTTPHeaderFields?.first)
        // Test its contents
        XCTAssertEqual(header.key, HTTPHeaderField.contentType.rawValue)
        XCTAssertEqual(header.value, HTTPHeaderValue.jsonContent.rawValue)
    }

    func testAddingInvalidJSONPayload() {
        // No payload
        var request = URLRequest(url: url)
        XCTAssertNil(request.httpBody)

        let params: JSON = ["a": ()]
        // Test error throwing
        XCTAssertThrowsError(try request.addJSONPayload(params), "") { error in
            XCTAssertEqual(error as? EncodingError, EncodingError.encodingFailed)
        }
    }

    func testAddingFormPayload() throws {
        // No payload
        var request = URLRequest(url: url)
        XCTAssertNil(request.httpBody)

        let params = ["a": "1"]

        // Add params
        try? request.addURLEncodedForm(params: params)
        XCTAssertNotNil(request.httpBody)

        // Test the presence of the right header
        XCTAssertNotNil(request.allHTTPHeaderFields)
        let header = try XCTUnwrap(request.allHTTPHeaderFields?.first)
        // Test its contents
        XCTAssertEqual(header.key, HTTPHeaderField.contentType.rawValue)
        XCTAssertEqual(header.value, HTTPHeaderValue.urlEncodedFormContent.rawValue)
    }

    func testCreatingRequestWithMethods() throws {
        let url = URL.from(string: "http://jadehopper.com")
        let getRequest = URLRequest(url: url)
        XCTAssertEqual(getRequest.httpMethod, "GET")

        let postRequest = URLRequest(url: url, httpMethod: .post)
        XCTAssertEqual(postRequest.httpMethod, "POST")

        let putRequest = URLRequest(url: url, httpMethod: .put)
        XCTAssertEqual(putRequest.httpMethod, "PUT")

        let patchRequest = URLRequest(url: url, httpMethod: .patch)
        XCTAssertEqual(patchRequest.httpMethod, "PATCH")

        let deleteRequest = URLRequest(url: url, httpMethod: .delete)
        XCTAssertEqual(deleteRequest.httpMethod, "DELETE")
    }

    func testAddingURLParams() throws {
        let username = "paulo"
        let password = "password"
        var request = URLRequest(url: url)
        request.addURLParameters(
            [
                "username": username,
                "password": password
            ]
        )
        XCTAssertEqual(request.url?.absoluteString, "\(url.absoluteString)?password=\(password)&username=\(username)")
    }

    func testAddingNoURLParams() throws {
        var request = URLRequest(url: url)
        request.addURLParameters([:])
        XCTAssertEqual(request.url?.absoluteString, url.absoluteString)
    }
}
