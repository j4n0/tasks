
import XCTest
@testable import Tasks

class TeamworkClientTests: XCTestCase
{
    let configuration = PlistConfiguration(forResource: "teamworkClientConfiguration", ofType: "plist", bundle: Bundle(for: TeamworkClientTests.self))
    
    var authentication: Authentication? {
        guard let apiKey = configuration?.apiKey, let company = configuration?.company else {
            XCTFail("Authentication is not available.")
            return nil
        }
        return Authentication(company: company, apiKey: apiKey)
    }
    
    var client: TeamworkClient? {
        guard let authentication = self.authentication else {
            XCTFail("client is not available.")
            return nil
        }
        return TeamworkClient(authentication: authentication)
    }
    
    func testConfiguration(){
        XCTAssertNotNil(configuration, "Missing configuration file for tests.")
        XCTAssertNotNil(configuration?.apiKey, "Missing API key in the configuration file.")
        XCTAssertNotNil(configuration?.company, "Missing company in the configuration file.")
    }
    
    func testAuthentication(){
        XCTAssertNotNil(authentication, "Expected non nil authentication.")
    }
    
    func testAllTasks(){
        let allTasksExpectation = expectation(description: "get all tasks across projects")
        client?.allTasks { result in
            switch result {
            case .success(let response):
                guard let status = response.status, status == "OK" else {
                    XCTFail("Expected OK status. Got \(response.status as Any)")
                    return
                }
                allTasksExpectation.fulfill()
            case .error(let e):
                XCTFail("\(e)")
            }
        }
        wait(for: [allTasksExpectation], timeout: 3)
    }
    
    func testTaskLists(){
        let taskListsExpectation = expectation(description: "get all task lists across projects")
        client?.taskLists { result in
            switch result {
            case .success(let response):
                guard let status = response.status, status == "OK" else {
                    XCTFail("Expected OK status. Got \(response.status as Any)")
                    return
                }
                taskListsExpectation.fulfill()
            case .error(let e):
                XCTFail("\(e)")
            }
        }
        wait(for: [taskListsExpectation], timeout: 3)
    }
    
    func testQuickAdd(){
        let quickAddExpectation = expectation(description: "get all task lists across projects")
        let projectId = "1"
        let quickAddBody = QuickAddBody(content: "one\ntwo")
        client?.quickadd(projectId: projectId, tasks: quickAddBody) { result in
            switch result {
            case .success(let response):
                guard let status = response.status, status == "OK" else {
                    XCTFail("Expected OK status. Got \(response.status as Any)")
                    return
                }
                quickAddExpectation.fulfill()
            case .error(let e):
                XCTFail("\(e)")
            }
        }
        wait(for: [quickAddExpectation], timeout: 3)
    }
    
    func testProjects(){
        let projectsExpectation = expectation(description: "Retrieves all projects.")
        client?.projects(query: nil) { result in
            switch result {
            case .success(let response):
                guard let status = response.status, status == "OK" else {
                    XCTFail("Expected OK status. Got \(response.status as Any)")
                    return
                }
                projectsExpectation.fulfill()
            case .error(let e):
                XCTFail("\(e)")
            }
        }
        wait(for: [projectsExpectation], timeout: 3)
    }
    
    func testMe(){
        let meExpectation = expectation(description: "Retrieves all projects.")
        client?.me(query: nil) { result in
            switch result {
            case .success(let response):
                guard let status = response.status, status == "OK" else {
                    XCTFail("Expected OK status. Got \(response.status as Any)")
                    return
                }
                meExpectation.fulfill()
            case .error(let e):
                XCTFail("\(e)")
            }
        }
        wait(for: [meExpectation], timeout: 3)
    }
}
