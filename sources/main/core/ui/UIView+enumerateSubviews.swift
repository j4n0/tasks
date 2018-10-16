
import UIKit

extension UIView
{
    func enumerateSubViews() -> [String: UIView] {
        var views = [String: UIView]()
        let mirror = Mirror(reflecting: self)
        for (_, attr) in mirror.children.enumerated() {
            if let property_name = attr.label {
                if let optional = attr.value as? OptionalProtocol {
                    if let view = optional as? UIView {
                        // UITextField shows up as "nameOfVariable.storage"
                        if let propertyName = "\(property_name)".split(separator: ".").first {
                            views[String(propertyName)] = view
                        }
                    } else {
                        // skipping nil attr.value
                    }
                } else if let view = attr.value as? UIView {
                    views["\(property_name)"] = view
                }
            }
        }
        return views
    }
}
