
import UIKit

enum FeedbackAnimation {
    case completion, discard
}
protocol FeedbackAnimating {
    var feedbackAnimation: FeedbackAnimation { get set }
}

final class SlideInAnimationController: NSObject, FeedbackAnimating
{
    let transitionDuration = 0.6
    let isPresentation: Bool
    var feedbackAnimation: FeedbackAnimation
    
    init(isPresentation: Bool, feedbackAnimation: FeedbackAnimation) {
        self.isPresentation = isPresentation
        self.feedbackAnimation = feedbackAnimation
        super.init()
    }
}

extension SlideInAnimationController: UIViewControllerAnimatedTransitioning
{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {
        let key = isPresentation ? UITransitionContextViewControllerKey.to : UITransitionContextViewControllerKey.from
        let controller = transitionContext.viewController(forKey: key)!
        
        if isPresentation {
            transitionContext.containerView.addSubview(controller.view)
        }
        
        let presentedFrame = transitionContext.finalFrame(for: controller)
        var dismissedFrame = presentedFrame
        dismissedFrame.origin.y = transitionContext.containerView.frame.size.height
        
        let initialFrame = isPresentation ? dismissedFrame : presentedFrame
        var finalFrame = isPresentation ? presentedFrame : dismissedFrame
        
        let animationDuration = transitionDuration(using: transitionContext)
        controller.view.frame = initialFrame
        
        // override finalFrame for 'discard' feedback
        if !isPresentation {
            switch feedbackAnimation {
            case .discard:
                let percentIncrease: CGFloat = 0.2
                finalFrame = initialFrame.insetBy(dx: -initialFrame.width * percentIncrease/2, dy: -initialFrame.height * percentIncrease/2)
            case .completion: ()
                /* ... todo: add a keyframe up to indicate success before dismissing down */
            }
        }
        
        controller.view.alpha = isPresentation ? 0.5 : 1.0
        let animator = UIViewPropertyAnimator(duration: animationDuration, dampingRatio: 0.8, animations: {
            controller.view.frame = finalFrame
            controller.view.alpha = self.isPresentation ? 1.0 : 0.0
        })
        animator.addCompletion { position in
            if case .end = position {
                transitionContext.completeTransition(true)
            }
        }
        animator.startAnimation()
    }
}
