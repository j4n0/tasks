
import XCTest
@testable import Tasks

class AllTasksResponseTests: XCTestCase
{
    func testEncodeResponse(){
        let decoded: AllTasksResponse? = XCTestCase.decodeJsonFile(resource: "AllTasksResponse", withExtension: "json")
        XCTAssertEqual(decoded?.status ?? "", "OK", "Expected status OK, got \(decoded?.status as Any)")
        // decoded.dumpJSON().flatMap { print($0) }
    }
    
    func testEncodeResponse2(){
        let decoded: AllTasksResponse? = XCTestCase.decodeJsonFile(resource: "AllTasksResponse2", withExtension: "json")
        XCTAssertEqual(decoded?.status ?? "", "OK", "Expected status OK, got \(decoded?.status as Any)")
        // decoded.dumpJSON().flatMap { print($0) }
    }
}
