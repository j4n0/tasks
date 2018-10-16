
import Foundation

protocol OptionalProtocol
{
    func wrappedType() -> Any.Type
    func isSome() -> Bool
    func unwrap() -> Any
}

extension Optional: OptionalProtocol
{
    func wrappedType() -> Any.Type {
        return Wrapped.self
    }
    func isSome() -> Bool {
        switch self {
        case .none: return false
        case .some: return true
        }
    }
    func unwrap() -> Any {
        switch self {
        case .none: preconditionFailure("nill unwrap")
        case .some(let unwrapped): return unwrapped
        }
    }
}
