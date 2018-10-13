
import Foundation

public struct KeyValueSerializer<T> {
    var read: (_ key: String) -> (T)
    var write: (_ key: String, _ value: T) -> ()
}

public protocol KeyValueStore {
    static var serializer: KeyValueSerializer<Any?> { get }
}
