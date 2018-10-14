
import XCTest
@testable import Tasks

class TasksSubQueryTests: XCTestCase
{
    let randomDate = RandomValues.date_YYYYMMDD
    let randomDateAndTime = RandomValues.dateTime_YYYYMMDDHHmmss
    let randomString: String = RandomValues.randomString
    let randomBool = RandomValues.randomBool
    let randomInt = RandomValues.randomUInt
    
    func testQueryDictionary()
    {
        var query = TasksSubQuery()
        query.completedAfterDate = randomDateAndTime
        query.filter = randomString
        query.endDate = randomDate
        query.getFiles = randomBool
        query.page = randomInt
        
        query.creatorIds = randomString
        query.responsiblePartyIds = randomString
        query.ignoreStartDates = randomBool
        query.tagIds = randomString
        
        guard let queryDictionary = try? query.queryDictionary() else {
            XCTFail("Failed to create a query dictionary")
            return
        }
        
        XCTAssertEqual(queryDictionary["completedAfterDate"], randomDateAndTime.stringValue)
        XCTAssertEqual(queryDictionary["filter"], randomString)
        XCTAssertEqual(queryDictionary["endDate"], randomDate.stringValue)
        XCTAssertEqual(queryDictionary["getFiles"], "\(randomBool)")
        XCTAssertEqual(queryDictionary["page"], "\(randomInt)")
        
        XCTAssertEqual(queryDictionary["creator-ids"], randomString)
        XCTAssertEqual(queryDictionary["responsible-party-ids"], randomString)
        XCTAssertEqual(queryDictionary["ignore-start-dates"], "\(randomBool)")
        XCTAssertEqual(queryDictionary["tag-ids"], randomString)
    }
}
