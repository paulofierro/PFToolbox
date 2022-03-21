import XCTest
@testable import PFToolbox

final class ResultTests: XCTestCase {
    func testURLCreation() {
        let result = getResult()
        switch result {
        case .success:
            // Do nothing
            break
            
        case .failure:
            XCTFail("Result should not be a failure")
        }
    }
    
    private func getResult() -> Result<Void, Error> {
        return .success
    }
}
