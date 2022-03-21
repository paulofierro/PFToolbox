import XCTest
@testable import PFToolbox

final class StringTests: XCTestCase {
    func testBoolValues() throws {
        let trueValue = "true"
        let yesValue = "yes"
        let oneValue = "1"
        let otherValue = "other"
        
        XCTAssertTrue(trueValue.boolValue)
        XCTAssertTrue(yesValue.boolValue)
        XCTAssertTrue(oneValue.boolValue)
        XCTAssertFalse(otherValue.boolValue)
    }
    
    func testOptionalBoolValues() throws {
        let trueValue: String?
        let yesValue: String?
        let oneValue: String?
        let otherValue: String?
        
        trueValue = "true"
        yesValue = "yes"
        oneValue = "1"
        otherValue = "other"
        
        XCTAssertTrue(trueValue.boolValue)
        XCTAssertTrue(yesValue.boolValue)
        XCTAssertTrue(oneValue.boolValue)
        XCTAssertFalse(otherValue.boolValue)
    }
    
    func testValidEmails() {
        let addresses: [String] = [
            "paulo@paulofierro.com",
            "paulo+test@paulofierro.com",
            "12345@paulofierro.com",
            "12345@paulofierro.co.uk",
            "12345@paulofierro.ky"
        ]
        for address in addresses {
            XCTAssertTrue(address.isValidEmailAddress)
        }
    }
    
    func testInvalidEmails() {
        let addresses: [String] = [
            "paulo.fierro?paulofierro.com",
            "",
            "12345@paulofierro",
            "http://paulofierro.com",
            "user:pass@paulofierro.com"
        ]
        for address in addresses {
            XCTAssertFalse(address.isValidEmailAddress)
        }
    }
    
    func testTrim() {
        let originalString = "This is a string"
        let string = "This is a string"
        let stringWithEndSpaces = "This is a string      "
        let stringWithSpaces = "       This is a string      "
        let stringWithNewlines = """
            This is a string

        """
        XCTAssertEqual(string.trim(), originalString)
        XCTAssertEqual(stringWithEndSpaces.trim(), originalString)
        XCTAssertEqual(stringWithSpaces.trim(), originalString)
        XCTAssertEqual(stringWithNewlines.trim(), originalString)
    }
    
    func testSubscript() {
        let string = ["1", "2", "3"]
        XCTAssertEqual(string[0], "1")
        XCTAssertEqual(string[1], "2")
        XCTAssertEqual(string[2], "3")

        // Test safe accessing
        XCTAssertEqual(string[safeIndex: 0], "1")
        XCTAssertEqual(string[safeIndex: 1], "2")
        XCTAssertEqual(string[safeIndex: 2], "3")
        XCTAssertNil(string[safeIndex: 3]) // Yay, nil!
    }
}
