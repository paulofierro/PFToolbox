import XCTest
@testable import PFToolbox

final class NetworkErrorTests: XCTestCase {
    
    func testEquality() throws {
        XCTAssertEqual(NetworkError.authenticationError(400).localizedDescription, "authenticationError(400)")
        XCTAssertEqual(NetworkError.badRequest(300).localizedDescription, "badRequest(300)")
        XCTAssertEqual(NetworkError.failed(404).localizedDescription, "failed(404)")
        XCTAssertEqual(NetworkError.noData(400).localizedDescription, "noData(400)")
        XCTAssertEqual(NetworkError.outdated(422).localizedDescription, "outdated(422)")
        XCTAssertEqual(NetworkError.notFound(404).localizedDescription, "notFound(404)")
        XCTAssertEqual(NetworkError.badResponse(500).localizedDescription, "badResponse(500)")
        XCTAssertEqual(NetworkError.invalidResponse.localizedDescription, "invalidResponse")
    }
}
