
import XCTest
@testable import Tasks

class CoordinatorTests: XCTestCase
{
    func testCoordinatorInitialisedWithTasks() {
        let coordinator = Coordinator(screen: .tasks)
        XCTAssertTrue(coordinator.navigationController.topViewController is TasksViewController)
    }
    
    func testCoordinatorInitialisedWithLogin() {
        let coordinator = Coordinator(screen: .login)
        XCTAssertTrue(coordinator.navigationController.topViewController is LoginViewController)
    }
    
}
