
import XCTest
@testable import Tasks

class UserDefaultsKeyValueStoreTests: XCTestCase
{
    private let store = Store<UserDefaultsKeyValueStore>()
    
    let company = "Acme"
    let authorizationHeaderValue = "DEADBEEF"
    
    func testWriteReadAuthentication()
    {
        store.authentication = Authentication(company: company, authorizationHeader: ["Authorization": authorizationHeaderValue])
        XCTAssertEqual(store.authentication?.company, company)
        XCTAssertEqual(store.authentication?.authorizationHeader["Authorization"], authorizationHeaderValue)
    }
}
