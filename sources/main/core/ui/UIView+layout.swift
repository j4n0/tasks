
import os
import UIKit

extension UIView
{
    func pinEdgesToSuperview(){
        guard let superview = superview else {
            os_log(.error, log: OSLog.default, "Expected to find a superview for %@", "\(self)")
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        ["H:|[view]|", "V:|[view]|"].forEach {
            superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: $0, options: [], metrics: nil, views: ["view": self]))
        }
    }
    
    func pinEdgesToSafeAreas(){
        guard let superview = superview else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor),
            bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor),
            leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor)
            ])
    }
    
    func centerVerticallyInParent(){
        superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: superview, attribute: .centerY, multiplier: 1, constant: 0))
    }
}

