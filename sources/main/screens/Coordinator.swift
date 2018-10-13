
import UIKit

public class Coordinator
{
    enum Screen {
        case login
        case home
    }
    
    private(set) var navigationController: UINavigationController!
    
    init(screen: Screen){
        self.navigationController = UINavigationController(rootViewController: controller(screen: screen))
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.isHidden = true
    }
    
    func show(screen: Screen){
        navigationController.show(controller(screen: screen), sender: self)
    }
    
    func alert(title: String, message: String, okAction: @escaping (UIAlertAction) -> Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: okAction))
        navigationController.present(alert, animated: true, completion: nil)
    }
    
    func controller(screen: Screen) -> UIViewController {
        switch screen {
        case .login:
            return LoginViewController()
        case .home:
            return TasksViewController()
        }
    }
}
