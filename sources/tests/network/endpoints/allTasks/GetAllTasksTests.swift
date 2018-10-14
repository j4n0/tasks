
import XCTest
@testable import Tasks

class GetAllTasksTests: XCTestCase
{
    let baseURL = URL(string: "http://tasks.com")!

    func testEncodeQuery() {
        if let query = try? GetAllTasksQuery().queryDictionary() {
            print(query)
        }
    }
  
    func testCreateResource() {
        let date = YYYYMMDDDate(date: Date())
        var query = TasksSubQuery()
        query.startDate = date
        let queryItems = (try? query.queryDictionary()) ?? [:]
        let resource = Resource(path: "/tasks.json", method: .get, query: queryItems)
        let request = URLRequest(resource: resource, baseURL: baseURL)
        guard let url = request?.url else {
            XCTFail("Invalid URL.")
            return
        }
        XCTAssertEqual(url.absoluteString, "http://tasks.com/tasks.json?startDate=\(date.stringValue)")
    }
    
    func testEncodeResponse(){
        let decoded: AllTasksResponse? = XCTestCase.decodeJsonFile(resource: "AllTasksResponse", withExtension: "json")
        guard let todoItem = decoded?.todoItems?.first else {
            XCTFail("Expected an item")
            return
        }
        XCTAssertEqual(todoItem.responsiblePartyFirstname, "Roisin")
        XCTAssertEqual(todoItem.id, 1)
        XCTAssertTrue(todoItem.viewEstimatedTime ?? false)
        XCTAssertNotNil(todoItem.createdOn)
        XCTAssertTrue(todoItem.tags?.count ?? 0 == 3)
        decoded.dumpJSON().flatMap { print($0) }
    }
}
