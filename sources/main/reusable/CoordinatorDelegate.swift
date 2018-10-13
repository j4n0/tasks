
import UIKit

protocol CoordinatorDelegate: class {
    func didFinish(_ controller: UIViewController)
}

extension CoordinatorDelegate where Self: UIViewController {
    func didFinish(_ controller: UIViewController) {
        remove(childController: controller)
    }
}
