
import UIKit

final class AppCoordinator: UIViewController
{
    var env: Environment { return environment }
    
    func start() {
        let coordinator = env.isAuthenticated ? MainCoordinator() : LoginCoordinator()
        startChildCoordinator(coordinator)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        children.first?.view.frame = view.bounds
    }
    
    func startChildCoordinator(_ coordinator: Coordinator){
        coordinator.delegate = self
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
