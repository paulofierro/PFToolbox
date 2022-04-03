import XCTest
@testable import PFToolbox

final class LoggerTests: XCTestCase {
    func testExistence() throws {
        let log = Logger()
        XCTAssertNotNil(log)
        
        // Should probably test std_err output
        log.verbose("verbose")
        log.debug("debug")
        log.info("info")
        log.warn("warn")
        log.error("error")
    }
}
