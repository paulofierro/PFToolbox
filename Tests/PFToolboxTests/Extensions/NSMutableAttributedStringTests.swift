import XCTest
@testable import PFToolbox

final class NSMutableAttributedStringTests: XCTestCase {
    
    #if canImport(UIKit)
    let color: UIColor = .red
    let font: UIFont = UIFont.systemFont(ofSize: 12)
    #elseif canImport(AppKit)
    let color: NSColor = .red
    let font: NSFont = NSFont.systemFont(ofSize: 12)
    #endif

    
    func testAddingAttributes() throws {
        let text = "This is my string"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: font
        ]

        // Create an attributed string with the attributes
        let stringA = NSAttributedString(
            string: text,
            attributes: attributes
        )

        // Create an attributed string without the attributes, and then
        // use our helper to apply them to the entire string.
        let stringB = NSMutableAttributedString(string: text)
        stringB.addAttributes(attributes)

        XCTAssertEqual(stringA, stringB)
    }
}
