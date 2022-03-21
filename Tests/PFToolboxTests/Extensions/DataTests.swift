import XCTest
@testable import PFToolbox

final class DataTests: XCTestCase {
    
    func testPrettyPrinting() throws {
        let json = ["name": "Paulo"]
        let data = try JSONSerialization.data(withJSONObject: json)
        XCTAssertNotNil(data)
        
        XCTAssertEqual(data.prettyPrinted(), """
        {
          "name" : "Paulo"
        }
        """)
    }
}
