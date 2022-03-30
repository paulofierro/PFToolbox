import XCTest
@testable import PFToolbox

final class BundleTests: XCTestCase {
    func testAppPath() throws {
        XCTAssertNotNil(Bundle.appPath.absoluteString)
    }
    
    func testExecutableName() throws {
        XCTAssertEqual(Bundle.main.executableName, "xctest")
    }
    
    func testBundleName() throws {
        XCTAssertEqual(Bundle.main.bundleName, "xctest")
    }
    
    func testVersionNumber() throws {
        XCTAssertTrue(Bundle.main.versionNumber?.contains("13."))
    }
    
    func testTeamIdentifier() throws {
        XCTAssertEqual(Bundle.main.teamIdentifierPrefix, "")
    }
    
    func testIdentifier() throws {
        XCTAssertEqual(Bundle.main.identifier, "Optional(\"com.apple.dt.xctest.tool\")")
    }
}
