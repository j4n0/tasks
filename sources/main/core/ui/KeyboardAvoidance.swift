
import UIKit

/**
 Handle keyboard avoidance. It uses the additionalSafeAreaInsets to decrease the size of the controller view. Usage:
 ```
 lazy var keyboard = KeyboardAvoidance(viewController: self)

 override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(animated)
     keyboardAvoidance.observeKeyboard()
 }
 
 override func viewWillDisappear(_ animated: Bool) {
     super.viewWillDisappear(animated)
     keyboardAvoidance.stopObservingKeyboard()
 }
 ```
 */
final class KeyboardAvoidance {
    
    private unowned var viewController: UIViewController
    private var onKeyboardWillChangeHeight: (CGFloat) -> Void = { height in
    }
    
    @available(iOS 11, *)
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    /// The closure takes the height of the keyboard frame as parameter.
    @available(iOS, obsoleted:11.0, message:"Use init(controllerView:) instead. Handling the keyboard is automatic in iOS 11.")
    init(viewController: UIViewController, onKeyboardWillChangeHeight: @escaping (CGFloat) -> Void) {
        self.viewController = viewController
        self.onKeyboardWillChangeHeight = onKeyboardWillChangeHeight
    }
    
    func observeKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardWillChangeFrame(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func stopObservingKeyboard() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc private func onKeyboardWillChangeFrame(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
        }
        var height: CGFloat = keyboardFrame.height
        if #available(iOS 11.0, *) {
            let keyboardFrameInView = viewController.view.convert(keyboardFrame, from: nil)
            let safeAreaFrame = viewController.view.safeAreaLayoutGuide.layoutFrame.insetBy(dx: 0, dy: -1 * viewController.additionalSafeAreaInsets.bottom)
            height = safeAreaFrame.intersection(keyboardFrameInView).height
        }
        let animationDuration: TimeInterval = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve = UIView.AnimationOptions(rawValue: animationCurveRaw)
        UIView.animate(withDuration: animationDuration, delay: 0, options: animationCurve, animations: {
            if #available(iOS 11.0, *) {
                self.viewController.additionalSafeAreaInsets.bottom = height
            } else {
                self.onKeyboardWillChangeHeight(height)
            }
            self.viewController.view.layoutIfNeeded()
        }, completion: nil)
    }
}
