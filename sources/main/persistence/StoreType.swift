
import Foundation

public protocol StoreType: CustomDebugStringConvertible {
    var authentication: Authentication? { get set }
    func removeEverything()
}
