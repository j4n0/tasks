
import XCTest
@testable import Tasks

class TasksSubQueryTests: XCTestCase
{
    let randomDate = YYYYMMDDDate(date: Date())
    let randomDateAndTime = YYYYMMDDHHmmssDate(date: Date())
    let randomString: String = "DEADBEEF".shuffled().map { String($0) }.joined()
    let randomBool = Bool.random()
    let randomInt = UInt.random(in: 0 ... 10)
    
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
