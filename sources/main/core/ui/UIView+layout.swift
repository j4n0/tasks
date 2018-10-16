
import os
import UIKit

extension UIView
{
    func pinEdgesToSuperview(){
        guard let superview = superview else {
            os_log("Expected to find a superview for %@", "\(self)")
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        ["H:|[view]|", "V:|[view]|"].forEach {
            superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: $0, options: [], metrics: nil, views: ["view": self]))
        }
    }
    
    func centerVerticallyInParent(){
        addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: superview, attribute: .centerY, multiplier: 1, constant: 0))
    }
}

