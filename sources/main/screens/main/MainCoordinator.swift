
import UIKit

class MainCoordinator: Coordinator {

    enum Screen {
        case editTask, tasks
    }
    
    func show(screen: Screen){
        super.show(controller: controller(screen: screen))
    }
    
    func controller(screen: Screen) -> UIViewController {
        switch screen {
        case .editTask:
            return UIViewController()
        case .tasks:
            return UIViewController()
        }
    }
    
    override func start(){
        if environment.isAuthenticated {
            let mainController = MainViewController(coordinatorDelegate: self)
            setRoot(controller: mainController)
        } else {
            super.finish()
        }
    }
}
