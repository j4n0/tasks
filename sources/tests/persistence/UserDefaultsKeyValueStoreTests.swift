
import XCTest
@testable import Tasks

final class UserDefaultsKeyValueStoreTests: XCTestCase
{
    private let store = Store<UserDefaultsKeyValueStore>()
    
    let company = "Acme"
    let authorizationHeaderValue = "DEADBEEF"
    
    override func tearDown() {
        super.tearDown()
        store.authentication = nil
    }
    
    func testWriteReadAuthentication()
    {
        store.authentication = Authentication(company: company, authorizationHeader: ["Authorization": authorizationHeaderValue])
        XCTAssertEqual(store.authentication?.company, company)
        XCTAssertEqual(store.authentication?.authorizationHeader["Authorization"], authorizationHeaderValue)
    }
}
