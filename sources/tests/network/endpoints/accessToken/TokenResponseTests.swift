
import XCTest
@testable import Tasks

class TokenResponseTests: XCTestCase
{
    func testEncodeResponse(){
        let decoded: AccessTokenResponse? = XCTestCase.decodeJsonFile(resource: "token", withExtension: "json")
        decoded.dumpJSON().flatMap { print($0) }
    }
}

