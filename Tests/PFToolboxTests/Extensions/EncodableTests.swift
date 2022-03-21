import XCTest
@testable import PFToolbox

final class EncodableTests: XCTestCase {
    
    struct MyStruct: Encodable {
        let name: String
    }
    
    func testJSONEncoding() throws {
        let value = MyStruct(name: "Paulo")
        let json = try value.toJSON()
        XCTAssertEqual(json, """
        {
          "name" : "Paulo"
        }
        """)
    }
}
