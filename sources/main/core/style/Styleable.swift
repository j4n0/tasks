
import UIKit

protocol Styleable {}

extension Styleable {
    func apply(_ style: (Self)->())->Self {
        style(self)
        return self
    }
}

extension UILabel: Styleable {}

