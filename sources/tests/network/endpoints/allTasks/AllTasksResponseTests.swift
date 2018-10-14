
import XCTest
@testable import Tasks

class AllTasksResponseTests: XCTestCase
{
    func testEncodeResponse(){
        let decoded: AllTasksResponse? = XCTestCase.decodeJsonFile(resource: "allTasksResponse", withExtension: "json")
        XCTAssertEqual(decoded?.status ?? "", "OK", "Expected status OK, got \(decoded?.status as Any)")
        // decoded.dumpJSON().flatMap { print($0) }
    }
}
