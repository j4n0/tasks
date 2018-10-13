
import Foundation

public struct UserDefaultsKeyValueStore: KeyValueStore
{
    public static var serializer: KeyValueSerializer<Any?> {
        return KeyValueSerializer(read: { key in
            return UserDefaults.standard.object(forKey: key)
        }, write: { key, value in
            UserDefaults.standard.set(value, forKey: key)
        })
    }
}
