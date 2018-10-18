
import XCTest
@testable import Tasks

final class PlistConfigurationTests: XCTestCase
{
    final class Dummy{}
    
    let expectedCompany = "Acme"
    let expectedApiKey = "DEADBEEF"
    
    func testReadExitingPlist() {
        guard let conf = PlistConfiguration(forResource: "PlistConfigurationTests", ofType: "plist", bundle: Bundle(for: Dummy.self)) else {
            XCTFail("Expected non nil configuration object.")
            return
        }
        guard let company = conf.company, let apiKey = conf.apiKey else {
            XCTFail("Expected non nil company and apiKey.")
            return
        }
        XCTAssertEqual(company, expectedCompany)
        XCTAssertEqual(apiKey, expectedApiKey)
    }
    
    func testNonExistingPlist() {
        let conf = PlistConfiguration(forResource: "xxx", ofType: "plist", bundle: Bundle(for: Dummy.self))
        XCTAssertNil(conf)
    }
}
