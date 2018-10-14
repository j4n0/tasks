
import Foundation

protocol Sugar {}

extension Sugar where Self: Any {
    func then(_ block: (inout Self) -> Void) -> Self {
        var copy = self
        block(&copy)
        return copy
    }
}

extension NSObject: Sugar {}
