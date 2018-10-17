
import XCTest
@testable import Tasks

class CoordinatorTests: XCTestCase
{
    func testCoordinatorInitialisedWithTasks() {
        let coordinator = Coordinator(screen: .taskList)
        XCTAssertTrue(coordinator.navigationController.topViewController is TaskListViewController)
    }
    
    func testCoordinatorInitialisedWithLogin() {
        let coordinator = Coordinator(screen: .login)
        XCTAssertTrue(coordinator.navigationController.topViewController is LoginViewController)
    }
    
}
