
import os
import UIKit

final class SlideInPresentationController: UIPresentationController
{
    let widthRatio: CGFloat = 5.0/6.0
    let heightRatio: CGFloat = 2.0/4.0
    let yOriginRatio: CGFloat = 1.0/9.0
    
    var onTapDimmedView: (UIViewController)->() = { presentingController in os_log("You tapped the dimmed view. Override me") }
    
    lazy var dimmingView = UIView().then {
        $0 = UIView()
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        $0.alpha = 0.0
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(SlideInPresentationController.handleTap(recognizer:)))
        $0.addGestureRecognizer(recognizer)
    }
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        roundCorners(controller: presentedViewController)
    }
    
    @objc dynamic func handleTap(recognizer: UITapGestureRecognizer) {
        environment.coordinator.dismissWithDiscardAnimation()
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var frame: CGRect = .zero
        frame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView!.bounds.size)
        frame.origin.y = containerView!.frame.height * yOriginRatio
        frame.origin.x = containerView!.frame.width * (1 - widthRatio) / 2.0
        return frame
    }
    
    func roundCorners(controller: UIViewController){
        controller.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        controller.view.clipsToBounds = true
        controller.view.layer.cornerRadius = 8
    }
    
    override func presentationTransitionWillBegin() {
        containerView?.insertSubview(dimmingView, at: 0)
        dimmingView.pinEdgesToSuperview()
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return
        }
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1.0
        })
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            return
        }
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
        })
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width * widthRatio, height: parentSize.height * heightRatio)
    }
}
