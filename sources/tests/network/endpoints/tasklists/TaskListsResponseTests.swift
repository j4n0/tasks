
import XCTest
@testable import Tasks

class TaskListsResponseTests: XCTestCase
{
    func testEncodeResponse(){
        let decoded: TaskListsResponse? = XCTestCase.decodeJsonFile(resource: "taskListsResponse", withExtension: "json")
        XCTAssertEqual(decoded?.status ?? "", "OK", "Expected status OK, got \(decoded?.status as Any)")
        // decoded.dumpJSON().flatMap { print($0) }
    }
}
