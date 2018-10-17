
import UIKit

public class Coordinator: UIResponder
{
    enum Screen {
        case login
        case taskList
        case taskCreate
        case taskDetail(TodoItem)
    }
    
    private(set) var navigationController: UINavigationController!
    
    init(screen: Screen){
        super.init()
        self.navigationController = UINavigationController(rootViewController: controller(screen: screen))
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.isHidden = true
    }
    
    func show(screens: [Screen]){
        DispatchQueue.main.async {
            self.navigationController.viewControllers = screens.map { self.controller(screen: $0) }
        }
    }
    
    func show(screen: Screen){
        DispatchQueue.main.async {
            self.navigationController.show(self.controller(screen: screen), sender: self)
        }
    }
    
    func pop(){
        DispatchQueue.main.async {
            self.navigationController.popViewController(animated: true)
        }
    }
    
    func alert(title: String, message: String, okAction: @escaping (UIAlertAction) -> Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: okAction))
        DispatchQueue.main.async {
            self.navigationController.present(alert, animated: true, completion: nil)
        }
    }
    
    func controller(screen: Screen) -> UIViewController {
        switch screen {
        case .login:
            let interactor = LoginInteractor(coordinator: self)
            return LoginViewController(url: LoginDetails.loginURL, navigationDelegate: interactor)
        case .taskList:
            return build() as TaskListViewController
        case .taskCreate:
            return build() as TaskCreateViewController
        case .taskDetail(let todoItem):
            return TaskDetailViewController(todoItem: todoItem)
        }
    }
}
