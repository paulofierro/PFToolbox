import XCTest
@testable import PFToolbox

final class EncodingErrorTests: XCTestCase {
    
    func testLocalizedErrors() throws {
        let error: EncodingError = .noData
        XCTAssertEqual(error.localizedDescription, "Encoded JSON is nil")
    }
}
