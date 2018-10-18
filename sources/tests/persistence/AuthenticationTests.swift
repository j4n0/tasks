
import XCTest
@testable import Tasks

final class AuthenticationTests: XCTestCase
{
    let company = "Acme"
    let authorizationHeaderKey = "Authorization"
    
    func testCompanyAndKey() {
        let authentication = Authentication(company: company, apiKey: "DEADBEEF")
        XCTAssertEqual(authentication.company, company)
        XCTAssertNotNil(authentication.authorizationHeader[authorizationHeaderKey])
    }
    
    func testCompanyAndToken() {
        let authentication = Authentication(company: company, accessToken: "DEADBEEF")
        XCTAssertEqual(authentication.company, company)
        XCTAssertNotNil(authentication.authorizationHeader[authorizationHeaderKey])
    }
    
    func testCompanyAndHeader() {
        let authentication = Authentication(company: company, authorizationHeader: ["Authorization": ""])
        XCTAssertEqual(authentication.company, company)
        XCTAssertNotNil(authentication.authorizationHeader[authorizationHeaderKey])
    }
}
