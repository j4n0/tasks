
import UIKit

final public class Coordinator: UIResponder
{
    enum Screen {
        case login
        case taskList
        case taskCreate
        case taskDetail(TodoItem)
    }
    
    private(set) var navigationController: UINavigationController!
    lazy var slideInTransitioningDelegate = SlideInTransitioningDelegate()
    
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
    
    func present(screen: Screen){
        DispatchQueue.main.async {
            let controller = self.controller(screen: screen)
            self.navigationController.topViewController?.present(controller, animated: true, completion: nil)
        }
    }
    
    func dismiss(){
        DispatchQueue.main.async {
            self.navigationController.dismiss(animated: true, completion: nil)
        }
    }
    
    func dismissWithSuccessAnimation(){
        slideInTransitioningDelegate.feedbackAnimation = .completion
        dismiss()
    }
    
    func dismissWithDiscardAnimation(){
        slideInTransitioningDelegate.feedbackAnimation = .discard
        dismiss()
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
            let controller = build() as TaskCreateViewController
            controller.transitioningDelegate = slideInTransitioningDelegate
            controller.modalPresentationStyle = .custom
            return controller
        case .taskDetail(let todoItem):
            return TaskDetailViewController(todoItem: todoItem)
        }
    }
}
