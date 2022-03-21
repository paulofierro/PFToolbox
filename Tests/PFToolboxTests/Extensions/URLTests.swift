import XCTest
@testable import PFToolbox

final class URLTests: XCTestCase {
    func testURLCreation() {
        let url = URL.from(string: "https://paulofierro.com")
        XCTAssertNotNil(url)
    }
}
