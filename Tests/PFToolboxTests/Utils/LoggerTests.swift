import XCTest
@testable import PFToolbox

final class LoggerTests: XCTestCase {
    func testExistence() throws {
        let log = Logger()
        XCTAssertNotNil(log)
    }
}
