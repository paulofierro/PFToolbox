//
//   EndpointTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation
@testable import PFToolbox
import Testing

struct EndpointTests {
    private struct StubEndpoint: Endpoint {
        var baseURL = URL.from(string: "https://test.com")
        var path = "path"
        var method: HTTPMethod = .get
        var headers: HTTPHeaders = [:]
        var urlParameters: Parameters = [:]
        var task: HTTPTask = .request
    }

    @Test func `conforming type supplies every requirement`() {
        let endpoint = StubEndpoint()
        #expect(endpoint.baseURL.absoluteString == "https://test.com")
        #expect(endpoint.path == "path")
        #expect(endpoint.method == .get)
        #expect(endpoint.headers.isEmpty)
        #expect(endpoint.urlParameters.isEmpty)
    }

    @Test func `http task cases carry their payloads`() {
        switch StubEndpoint().task {
        case .request:
            break
        default:
            Issue.record("Expected the request case")
        }

        let form = HTTPTask.requestWithForm(["a": "1"])
        guard case .requestWithForm(let params) = form else {
            Issue.record("Expected the form case")
            return
        }
        #expect(params == ["a": "1"])

        let payload = HTTPTask.requestWithJSONPayload(nil)
        guard case .requestWithJSONPayload(let value) = payload else {
            Issue.record("Expected the JSON payload case")
            return
        }
        #expect(value == nil)
    }
}
