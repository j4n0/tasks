
import XCTest
@testable import Tasks

final class MockedTeamworkClientTests: XCTestCase
{
    let client = MockedTeamworkClient()
    
    func checkResult<T>(exp: XCTestExpectation, result: ApiResult<T>){
        switch result {
        case .success(let response): XCTAssertNotNil(response)
        case .error(let error): XCTFail(error.localizedDescription)
        }
        exp.fulfill()
        /*
         Client.mockedSession.nextDataTask.resumeWasCalled is not called because it completes inside the task creation.
         Do I need to simulate this with a delay?
         XCTAssertTrue(client.mockedSession.nextDataTask.resumeWasCalled, "Resume was not called while reading \(type(of: result))")
        */
    }
    
    func testAllTasks()
    {
        let exp = expectation(description: "Get all tasks across projects")
        client.allTasks { (result: ApiResult<AllTasksResponse>) in
            self.checkResult(exp: exp, result: result)
        }
        wait(for: [exp], timeout: 1)
    }
    
    func testTaskLists()
    {
        let exp = expectation(description: "Get all task lists across projects")
        client.taskLists(query: nil) { (result: ApiResult<TaskListsResponse>) in
            self.checkResult(exp: exp, result: result)
        }
        wait(for: [exp], timeout: 1)
    }
    
    func testQuickAdd()
    {
        let exp = expectation(description: "Get all task lists across projects")
        let body = QuickAddBody(content: "one\ntwo")
        client.quickadd(projectId: "", tasks: body) { (result: ApiResult<QuickAddResponse>) in
            self.checkResult(exp: exp, result: result)
        }
        wait(for: [exp], timeout: 1)
    }
    
    func testProjects()
    {
        let exp = expectation(description: "Retrieves all projects")
        client.projects(query: nil) { (result: ApiResult<ProjectsResponse>) in
            self.checkResult(exp: exp, result: result)
        }
        wait(for: [exp], timeout: 1)
    }
}
