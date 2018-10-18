
import XCTest
@testable import Tasks

final class TaskListsQueryTests: XCTestCase
{
    private let page = RandomValues.randomString
    private let pageSize: String = RandomValues.randomString
    private let status = RandomValues.randomString

    func testQueryDictionary()
    {
        var query = TaskListsQuery()
        var pagination = PaginationSubQuery()
        pagination.page = page
        pagination.pageSize = pageSize
        pagination.status = status
        query.pagination = pagination
        
        guard let queryDictionary = try? query.queryDictionary() else {
            XCTFail("Failed to create a query dictionary")
            return
        }
        
        XCTAssertEqual(queryDictionary["status"], status)
        XCTAssertEqual(queryDictionary["page"], page)
        XCTAssertEqual(queryDictionary["pageSize"], pageSize)
    }
}
