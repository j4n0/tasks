
import XCTest
@testable import Tasks

class MockedAuthenticatingClientTests: XCTestCase
{
    // when passed a mocked session that returns the JSON for an AccessTokenResponse
    func testAccessToken()
    {
        let accessTokenExpectation = expectation(description: "get access token")
        let client = MockedAuthenticatingClient()
        client.accessToken(authenticationCode: "unused") { (result: ApiResult<AccessTokenResponse>) in
            switch result {
            case .success(let response): XCTAssertNotNil(response.accessToken)
            case .error(let error): XCTFail(error.localizedDescription)
            }
            accessTokenExpectation.fulfill()
        }
        wait(for: [accessTokenExpectation], timeout: 1)
    }
}
