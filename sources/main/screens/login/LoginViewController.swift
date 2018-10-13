
import os
import UIKit

class LoginViewController: UIViewController {
    
    unowned let coordinatorDelegate: CoordinatorDelegate
    
    init(coordinatorDelegate: CoordinatorDelegate){
        self.coordinatorDelegate = coordinatorDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func returnControl(){
        coordinatorDelegate.didFinish(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(2)) {
            os_log("let’s pretend I finished authenticating")
            self.didFinishAuthenticating()
        }
    }
    
    func didFinishAuthenticating(){
        environment.isAuthenticated = true
        self.returnControl()
    }
}

