import XCTest
@testable import PFToolbox

final class ErrorTests: XCTestCase {
    let url = URL.from(string: "http://paulofierro.com")

    func testComparingDecodingError() throws {
        XCTAssertEqual(DecodingError.fileNotFound("abc.json"), DecodingError.fileNotFound("abc.json"))
    }

    func testComparingEncodingError() throws {
        XCTAssertEqual(EncodingError.noData, EncodingError.noData)
        XCTAssertNotEqual(EncodingError.noData, EncodingError.encodingFailed)
    }
}
