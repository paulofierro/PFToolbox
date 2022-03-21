import XCTest
@testable import PFToolbox

final class CGSizeTests: XCTestCase {
    func testOrientation() {
        let square = CGSize(width: 100, height: 100)
        let landscape = CGSize(width: 200, height: 100)
        let portrait = CGSize(width: 100, height: 200)
        
        XCTAssertTrue(square.isSquare)
        XCTAssertTrue(landscape.isLandscape)
        XCTAssertTrue(portrait.isPortrait)
    }
}
