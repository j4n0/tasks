
import XCTest

extension XCTestCase
{
    func wait(for element: XCUIElement, timeout duration: TimeInterval) {
        let predicate = NSPredicate(format: "exists == true")
        let _ = expectation(for: predicate, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: duration + 0.5) // CI servers are slow
    }
}
