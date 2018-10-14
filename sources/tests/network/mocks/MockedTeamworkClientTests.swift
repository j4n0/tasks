
import XCTest
@testable import Tasks

class MockedTeamworkClientTests: XCTestCase
{
    // when passed a mocked session that returns the JSON for an AccessTokenResponse
    func testAllTasks()
    {
        let allTasksExpectation = expectation(description: "get all tasks")
        let client = MockedTeamworkClient()
        client.allTasks { (result: ApiResult<AllTasksResponse>) in
            switch result {
            case .success(let response): XCTAssertNotNil(response)
            case .error(let error): XCTFail(error.localizedDescription)
            }
            allTasksExpectation.fulfill()
        }
        XCTAssertTrue(client.mockedSession.nextDataTask.resumeWasCalled)
        wait(for: [allTasksExpectation], timeout: 1)
    }
}
