
import os
import UIKit

class Coordinator: UIViewController {
    
    private var embeddedNavigationController: UINavigationController!
    unowned let coordinatorDelegate: CoordinatorDelegate
    
    init(coordinatorDelegate: CoordinatorDelegate){
        self.coordinatorDelegate = coordinatorDelegate
        embeddedNavigationController = UINavigationController()
        super.init(nibName: nil, bundle: nil)
        embeddedNavigationController.delegate = self
        add(childController: embeddedNavigationController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start(){
        fatalError("Override this to create a controller, set its delegate, and set a root")
    }
    
    func setRoot(controller: UIViewController){
        embeddedNavigationController.viewControllers = [controller]
    }
    
    func finish(){
        coordinatorDelegate.didFinish(self)
    }
    
    func show(controller: UIViewController){
        embeddedNavigationController.show(controller, sender: self)
    }
    
    func alert(title: String, message: String, okAction: @escaping (UIAlertAction) -> Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: okAction))
        embeddedNavigationController.present(alert, animated: true, completion: nil)
    }
}

extension Coordinator: CoordinatorDelegate {
    
    func didFinish(_ controller: UIViewController) {
        remove(childController: controller)
        start()
    }
}

extension Coordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        os_log("willShow %@", viewController)
    }
}
