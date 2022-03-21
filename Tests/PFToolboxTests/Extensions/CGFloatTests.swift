import XCTest
@testable import PFToolbox

final class CGFloatTests: XCTestCase {
    func testDegreesToRadians() {
        let value: CGFloat = 180
        XCTAssertEqual(value.degreesToRadians(), Double.pi)
    }
}
