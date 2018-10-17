
import XCTest
@testable import Tasks

class ProjectsResponseTests: XCTestCase
{
    func testEncodeResponse(){
        let decoded: ProjectsResponse? = XCTestCase.decodeJsonFile(resource: "projectsResponse", withExtension: "json")
        XCTAssertEqual(decoded?.status ?? "", "OK", "Expected status OK, got \(decoded?.status as Any)")
        decoded.dumpJSON().flatMap { print($0) }
    }
}
