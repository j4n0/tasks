
import UIKit

class LoginCoordinator: Coordinator {
    
    override func start() {
        if environment.isAuthenticated {
            coordinatorDelegate.didFinish(self)
        } else {
            let loginController = LoginViewController(coordinatorDelegate: self)
            setRoot(controller: loginController)
        }
    }
}
