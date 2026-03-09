//
//   URLRequestTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation
@testable import PFToolbox
import Testing

struct URLRequestTests {
    private let url = URL.from(string: "https://paulofierro.com")

    @Test func addingHeaderArray() throws {
        // No headers
        var request = URLRequest(url: url)
        #expect(request.allHTTPHeaderFields == nil)

        // Add nothing
        request.addHeaders(nil)
        #expect(request.allHTTPHeaderFields == nil)

        // Add header
        let value = "something"
        let headers: HTTPHeaders = [.contentType: .generic(string: value)]
        request.addHeaders(headers)

        // Test its presence
        #expect(request.allHTTPHeaderFields != nil)
        let header = try #require(request.allHTTPHeaderFields?[HTTPHeaderField.contentType.rawValue])
        // Test its contents
        #expect(header == value)
    }

    @Test func addingDefinedHeader() throws {
        // No headers
        var request = URLRequest(url: url)
        #expect(request.allHTTPHeaderFields == nil)

        request.addValue(.jsonContent, for: .contentType)
        #expect(request.allHTTPHeaderFields != nil)

        // Test its presence
        #expect(request.allHTTPHeaderFields != nil)
        let header = try #require(request.allHTTPHeaderFields?[HTTPHeaderField.contentType.rawValue])
        // Test its contents
        #expect(header == HTTPHeaderValue.jsonContent.rawValue)
    }

    @Test func addingStringHeader() throws {
        // No headers
        var request = URLRequest(url: url)
        #expect(request.allHTTPHeaderFields == nil)

        request.addValue(HTTPHeaderValue.jsonContent.rawValue, for: .contentType)
        #expect(request.allHTTPHeaderFields != nil)

        // Test its presence
        #expect(request.allHTTPHeaderFields != nil)
        let header = try #require(request.allHTTPHeaderFields?[HTTPHeaderField.contentType.rawValue])
        // Test its contents
        #expect(header == HTTPHeaderValue.jsonContent.rawValue)
    }

    @Test func uploadMethods() {
        let uploadMethods: [HTTPMethod] = [.post, .put, .patch]
        let downloadMethods: [HTTPMethod] = [.get, .delete]

        for uploadMethod in uploadMethods {
            #expect(uploadMethod.isUploadMethod)
        }

        for downloadMethod in downloadMethods {
            #expect(!downloadMethod.isUploadMethod)
        }
    }

    @Test func addingJSONPayload() throws {
        // No payload
        var request = URLRequest(url: url)
        #expect(request.httpBody == nil)

        let params: JSON = ["a": "1"]

        // Add params
        try? request.addJSONPayload(params)
        #expect(request.httpBody != nil)

        // Test the presence of the right header
        #expect(request.allHTTPHeaderFields != nil)
        let header = try #require(request.allHTTPHeaderFields?.first)
        // Test its contents
        #expect(header.key == HTTPHeaderField.contentType.rawValue)
        #expect(header.value == HTTPHeaderValue.jsonContent.rawValue)
    }

    @Test func addingInvalidJSONPayload() {
        // No payload
        var request = URLRequest(url: url)
        #expect(request.httpBody == nil)

        let params: JSON = ["a": ()]
        // Test error throwing
        #expect(throws: EncodingError.encodingFailed) {
            try request.addJSONPayload(params)
        }
    }

    @Test func addingFormPayload() throws {
        // No payload
        var request = URLRequest(url: url)
        #expect(request.httpBody == nil)

        let params = ["a": "1"]

        // Add params
        try? request.addURLEncodedForm(params: params)
        #expect(request.httpBody != nil)

        // Test the presence of the right header
        #expect(request.allHTTPHeaderFields != nil)
        let header = try #require(request.allHTTPHeaderFields?.first)
        // Test its contents
        #expect(header.key == HTTPHeaderField.contentType.rawValue)
        #expect(header.value == HTTPHeaderValue.urlEncodedFormContent.rawValue)
    }

    @Test func creatingRequestWithMethods() {
        let url = URL.from(string: "http://jadehopper.com")
        let getRequest = URLRequest(url: url)
        #expect(getRequest.httpMethod == "GET")

        let postRequest = URLRequest(url: url, httpMethod: .post)
        #expect(postRequest.httpMethod == "POST")

        let putRequest = URLRequest(url: url, httpMethod: .put)
        #expect(putRequest.httpMethod == "PUT")

        let patchRequest = URLRequest(url: url, httpMethod: .patch)
        #expect(patchRequest.httpMethod == "PATCH")

        let deleteRequest = URLRequest(url: url, httpMethod: .delete)
        #expect(deleteRequest.httpMethod == "DELETE")
    }

    @Test func addingURLParams() {
        let username = "paulo"
        let password = "password"
        var request = URLRequest(url: url)
        request.addURLParameters(
            [
                "username": username,
                "password": password
            ]
        )
        #expect(request.url?.absoluteString == "\(url.absoluteString)?password=\(password)&username=\(username)")
    }

    @Test func addingNoURLParams() {
        var request = URLRequest(url: url)
        request.addURLParameters([:])
        #expect(request.url?.absoluteString == url.absoluteString)
    }

    @Test func buildStartRequest() throws {
        let request = try URLRequest.buildRequest(
            from: TestEndpoint.start,
            cachePolicy: .returnCacheDataDontLoad,
            timeoutInterval: 10
        )
        #expect(request.url?.absoluteString == "https://test.com/start")
        #expect(request.cachePolicy == .returnCacheDataDontLoad)
        #expect(request.timeoutInterval == 10)
        #expect(request.httpMethod == "GET")
        #expect(request.allHTTPHeaderFields == [:])
    }

    @Test func buildLoginRequest() throws {
        let username = "user"
        let password = "pass"
        let request = try URLRequest.buildRequest(
            from: TestEndpoint.login(
                username: username,
                password: password
            )
        )
        #expect(request.url?.absoluteString == "https://test.com/login?password=\(password)&username=\(username)")
        #expect(request.cachePolicy == .reloadIgnoringLocalAndRemoteCacheData)
        #expect(request.timeoutInterval == 60)
        #expect(request.httpMethod == "POST")
        #expect(request.allHTTPHeaderFields?[HTTPHeaderField.cacheControl.rawValue] == HTTPHeaderValue.noCache.rawValue)

        let data = try #require(request.httpBody)
        let string = try #require(String(data: data, encoding: .utf8))
        #expect(string.contains("password=\(password)"))
        #expect(string.contains("username=\(username)"))
    }

    @Test func buildPostDataRequest() throws {
        let message = "Hello world"
        let request = try URLRequest.buildRequest(
            from: TestEndpoint.postData(message: message)
        )
        #expect(request.url?.absoluteString == "https://test.com/postMessage")
        #expect(request.cachePolicy == .reloadIgnoringLocalAndRemoteCacheData)
        #expect(request.timeoutInterval == 60)
        #expect(request.httpMethod == "POST")
        #expect(request.allHTTPHeaderFields == [HTTPHeaderField.contentType.rawValue: HTTPHeaderValue.jsonContent.rawValue])

        let json = try #require(MessagePayload(message: message).toJSON())
        let serializedPayload = try JSONSerialization.data(withJSONObject: json)
        #expect(request.httpBody == serializedPayload)
    }

    @Test func buildPostDataRequestWithIllegalData() throws {
        let request = try URLRequest.buildRequest(
            from: TestEndpoint.invalidEndpoint
        )
        #expect(request.cachePolicy == .reloadIgnoringLocalAndRemoteCacheData)
        #expect(request.timeoutInterval == 60)
        #expect(request.httpMethod == "POST")

        // Invalid data, so no content type was added
        #expect(request.allHTTPHeaderFields == [:])
        #expect(request.httpBody == nil)
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
