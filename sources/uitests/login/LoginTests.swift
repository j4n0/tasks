
import XCTest
@testable import Tasks

final class LoginTests: XCTestCase
{
    var app: XCUIApplication!
    
    let testUserMail = "yat@triplespin.com"
    let testUserPassword = "yatyatyat27"
    
    override func setUp(){
        continueAfterFailure = false
        app = XCUIApplication()
        // I’m passing the bundle id as launch argument to prepare for ui tests by removing persistence.
        let uiTests = "es.com.jano.tasks.tasksUITests"
        app.launchArguments.append(uiTests)
        app.launch()
    }
    
    func testLogin()
    {
        let form = LoginScreen(app: app)
        wait(for: form.loginButton, timeout: 5)
        
        form.emailTextField.tap()
        form.emailTextField.typeText(testUserMail)
        
        form.emailTextField.typeText(XCUIKeyboardKey.tab.rawValue)
        
        // Note that app.textFields.secureTextFields.firstMatch won’t work, maybe to avoid brute force attacks on secure fields.
        // We can type XCUIKeyboardKey.tab.rawValue or rely on the position of the element on screen.
        //form.passwordCoordinate.tap()
        
        app.typeText(testUserPassword)
        
        form.loginButton.tap()
        wait(for: form.loginSuccessful, timeout: 5)
    }
}

struct LoginScreen
{
    private var app: XCUIApplication
    
    init(app: XCUIApplication){
        self.app = app
    }
    
    var emailTextField: XCUIElement {
        return app.textFields.firstMatch
    }
    
    var passwordCoordinate: XCUICoordinate {
        let vector = CGVector(dx: 1, dy: 1)
        return emailTextField.coordinate(withNormalizedOffset: vector)
    }
    
    var loginButton: XCUIElement {
        return app.buttons["Log In"]
    }
    
    var loginSuccessful: XCUIElement {
        return app.staticTexts["Login successful"]
    }
}
