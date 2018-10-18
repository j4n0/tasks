
import UIKit

final class SlideInTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate
{
    var feedbackAnimation: FeedbackAnimation = .completion
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = SlideInPresentationController(presentedViewController: presented, presenting: presenting)
        presentationController.delegate = self
        return presentationController
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInAnimationController(isPresentation: true, feedbackAnimation: feedbackAnimation)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInAnimationController(isPresentation: false, feedbackAnimation: feedbackAnimation)
    }
}

extension SlideInTransitioningDelegate: UIAdaptivePresentationControllerDelegate
{    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        return nil
    }
}

