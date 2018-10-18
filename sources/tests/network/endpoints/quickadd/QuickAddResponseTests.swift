
import XCTest
@testable import Tasks

final class QuickAddResponseTests: XCTestCase
{
    func testEncodeResponse(){
        let decoded: QuickAddResponse? = XCTestCase.decodeJsonFile(resource: "quickaddResponse", withExtension: "json")
        XCTAssertEqual(decoded?.status ?? "", "OK", "Expected status OK, got \(decoded?.status as Any)")
        // decoded.dumpJSON().flatMap { print($0) }
    }
}
