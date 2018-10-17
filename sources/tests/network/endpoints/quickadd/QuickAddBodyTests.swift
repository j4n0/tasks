
import XCTest
@testable import Tasks

class QuickAddBodyTests: XCTestCase
{
    func testEncodeResponse(){
        let decoded: QuickAddBody? = XCTestCase.decodeJsonFile(resource: "quickAddBody", withExtension: "json")
        XCTAssertNotNil(decoded)
        // decoded.dumpJSON().flatMap { print($0) }
    }
}
