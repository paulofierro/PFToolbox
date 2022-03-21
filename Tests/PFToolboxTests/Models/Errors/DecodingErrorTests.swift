import XCTest
@testable import PFToolbox

final class DecodingErrorTests: XCTestCase {
    
    func testLocalizedErrors() throws {
        let error: DecodingError = .fileNotFound("readme.txt")
        XCTAssertEqual(error.localizedDescription, "File not found: readme.txt")
    }
}
