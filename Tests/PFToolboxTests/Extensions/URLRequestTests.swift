//
//   URLRequestTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
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

        for uploadMethod in uploadMethods {
            XCTAssertTrue(uploadMethod.isUploadMethod)
        }

        for downloadMethod in downloadMethods {
            XCTAssertFalse(downloadMethod.isUploadMethod)
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

    func testBuildStartRequest() throws {
        let request = try URLRequest.buildRequest(
            from: TestEndpoint.start,
            cachePolicy: .returnCacheDataDontLoad,
            timeoutInterval: 10
        )
        XCTAssertEqual(request.url?.absoluteString, "https://test.com/start")
        XCTAssertEqual(request.cachePolicy, .returnCacheDataDontLoad)
        XCTAssertEqual(request.timeoutInterval, 10)
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.allHTTPHeaderFields, [:])
    }

    func testBuildLoginRequest() throws {
        let username = "user"
        let password = "pass"
        let request = try URLRequest.buildRequest(
            from: TestEndpoint.login(
                username: username,
                password: password
            )
        )
        XCTAssertEqual(request.url?.absoluteString, "https://test.com/login?password=\(password)&username=\(username)")
        XCTAssertEqual(request.cachePolicy, .reloadIgnoringLocalAndRemoteCacheData)
        XCTAssertEqual(request.timeoutInterval, 60)
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.allHTTPHeaderFields?[HTTPHeaderField.cacheControl.rawValue], HTTPHeaderValue.noCache.rawValue)

        let data = try XCTUnwrap(request.httpBody)
        let string = try XCTUnwrap(String(data: data, encoding: .utf8))
        XCTAssertTrue(string.contains("password=\(password)"))
        XCTAssertTrue(string.contains("username=\(username)"))
    }

    func testBuildPostDataRequest() throws {
        let message = "Hello world"
        let request = try URLRequest.buildRequest(
            from: TestEndpoint.postData(message: message)
        )
        XCTAssertEqual(request.url?.absoluteString, "https://test.com/postMessage")
        XCTAssertEqual(request.cachePolicy, .reloadIgnoringLocalAndRemoteCacheData)
        XCTAssertEqual(request.timeoutInterval, 60)
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.allHTTPHeaderFields, [HTTPHeaderField.contentType.rawValue: HTTPHeaderValue.jsonContent.rawValue])

        let json = try XCTUnwrap(MessagePayload(message: message).toJSON())
        let serializedPayload = try JSONSerialization.data(withJSONObject: json)
        XCTAssertEqual(request.httpBody, serializedPayload)
    }

    func testBuildPostDataRequestWithIllegalData() throws {
        let request = try URLRequest.buildRequest(
            from: TestEndpoint.invalidEndpoint
        )
        XCTAssertEqual(request.cachePolicy, .reloadIgnoringLocalAndRemoteCacheData)
        XCTAssertEqual(request.timeoutInterval, 60)
        XCTAssertEqual(request.httpMethod, "POST")

        // Invalid data, so no content type was added
        XCTAssertEqual(request.allHTTPHeaderFields, [:])
        XCTAssertNil(request.httpBody)
    }
}

private enum TestEndpoint {
    case start
    case login(username: String, password: String)
    case postData(message: String)
    case invalidEndpoint
}

extension TestEndpoint: Endpoint {
    public var baseURL: URL {
        switch self {
        case .invalidEndpoint:
            URL.from(string: "file://")
        default:
            URL.from(string: "https://test.com")
        }
    }

    public var path: String {
        switch self {
        case .start:
            "start"

        case .login:
            "login"

        case .postData:
            "postMessage"

        case .invalidEndpoint:
            "invalid"
        }
    }

    public var method: HTTPMethod {
        switch self {
        case .start:
            .get

        default:
            .post
        }
    }

    public var task: HTTPTask {
        switch self {
        case .start, .invalidEndpoint:
            return .request

        case .login(let username, let password):
            return .requestWithForm([
                "username": username,
                "password": password
            ])

        case .postData(let message):
            let payload = MessagePayload(message: message)
            return .requestWithJSONPayload(payload)
        }
    }

    public var headers: HTTPHeaders {
        switch self {
        case .login:
            [
                .cacheControl: .noCache
            ]
        default:
            [:]
        }
    }

    public var urlParameters: Parameters {
        switch self {
        case .login(let username, let password):
            [
                "username": username,
                "password": password
            ]
        default:
            [:]
        }
    }
}

struct MessagePayload: Payload {
    let message: String
}
