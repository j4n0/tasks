
import XCTest
@testable import Tasks

class MeResponseTests: XCTestCase
{
    func testEncodeResponse(){
        let decoded: MeResponse? = XCTestCase.decodeJsonFile(resource: "meResponse", withExtension: "json")
        XCTAssertEqual(decoded?.status ?? "", "OK", "Expected status OK, got \(decoded?.status as Any)")
        decoded.dumpJSON().flatMap { print($0) }
    }
}
