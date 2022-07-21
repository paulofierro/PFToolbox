import XCTest
@testable import PFToolbox

#if canImport(AppKit)
final class NSViewTests: XCTestCase {
    
    func testPinningEdges() throws {
        let superView = NSView(frame: .zero)
        let view = NSView(frame: .zero)
        
        XCTAssertTrue(view.translatesAutoresizingMaskIntoConstraints)
        XCTAssertTrue(view.constraints.isEmpty)
        
        superView.addSubview(view)
        view.pinEdges(to: superView)
        
        XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
        XCTAssertTrue(view.constraints.isEmpty)
    }
}
#endif
