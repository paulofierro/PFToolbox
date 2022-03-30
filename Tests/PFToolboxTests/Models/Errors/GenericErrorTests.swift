import XCTest
@testable import PFToolbox

final class GenericErrorTests: XCTestCase {
    
    func testLocalizedErrors() throws {
        let message = "Something happened"
        let error: GenericError = .custom(message)
        XCTAssertEqual(error.localizedDescription, message)
    }
}