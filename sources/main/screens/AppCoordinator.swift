
import UIKit

final class AppCoordinator: UIViewController
{   
    func start() {
        startChildCoordinator(nextCoordinator())
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        children.first?.view.frame = view.bounds
    }
    
    func nextCoordinator() -> Coordinator {
        return environment.isAuthenticated
            ? MainCoordinator(coordinatorDelegate: self)
            : LoginCoordinator(coordinatorDelegate: self)
    }
    
    func startChildCoordinator(_ coordinator: Coordinator){
        add(childController: coordinator)
        coordinator.start()
    }
}

extension AppCoordinator: CoordinatorDelegate {
    
    func didFinish(_ coordinator: UIViewController){
        remove(childController: coordinator)
        start()
    }
}
