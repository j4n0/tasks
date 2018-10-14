
import XCTest
@testable import Tasks

class AllTasksResponseTests: XCTestCase
{
    func testEncodeResponse(){
        let decoded: AllTasksResponse? = XCTestCase.decodeJsonFile(resource: "AllTasksResponse", withExtension: "json")
        decoded.dumpJSON().flatMap { print($0) }
    }
    
    func testEncodeResponse2(){
        let decoded: AllTasksResponse? = XCTestCase.decodeJsonFile(resource: "AllTasksResponse2", withExtension: "json")
        decoded.dumpJSON().flatMap { print($0) }
    }
}

extension Encodable
{
    func dumpJSON() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let jsonData = try? encoder.encode(self) else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
}
