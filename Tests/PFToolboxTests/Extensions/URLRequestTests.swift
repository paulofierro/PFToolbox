import XCTest
@testable import PFToolbox

final class URLRequestTests: XCTestCase {
    func testAddingHeaders() throws {
        // No headers
        var request = URLRequest(url: URL(string: "https://paulofierro.com")!)
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
        var request = URLRequest(url: URL(string: "https://paulofierro.com")!)
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
        var request = URLRequest(url: URL(string: "https://paulofierro.com")!)
        XCTAssertNil(request.httpBody)

        let params: JSON = ["a": ()]
        // Test error throwing
        XCTAssertThrowsError(try request.addJSONPayload(params), "") { error in
            XCTAssertEqual(error as? EncodingError, EncodingError.encodingFailed)
        }
    }
}
