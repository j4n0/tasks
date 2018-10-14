
import Foundation

enum QueryDictionaryConvertibleError: Error {
    case notStructOrClass(Any)
    case unknownPropertyType(Any)
}

/// Uses reflection to turn a struct or class into a dictionary.
protocol QueryDictionaryConvertible
{
    /// Return the current object as a single dictionary.
    /// Fields with type QueryDictionaryConvertible will be flatted out (no nested dictionaries are returned).
    /// Fields with type CustomDate will use a call to `description` to generate a string value.
    func queryDictionary() throws -> [String: String]
    
    /// Lets you rename the keys of the dictionary returned. Each key/value pair represents an old key/new key.
    var renamePropertyKeys: [String: String]? { get }
}

extension QueryDictionaryConvertible
{
    func queryDictionary() throws -> [String: String] {
        var result = [String: String]()
        let mirror = Mirror(reflecting: self)
        guard let style = mirror.displayStyle, style == Mirror.DisplayStyle.struct || style == Mirror.DisplayStyle.class else {
            throw QueryDictionaryConvertibleError.notStructOrClass(self)
        }
        for case (let labelMaybe, Optional<Any>.some(let value)) in mirror.children {
            guard let label = labelMaybe else {
                continue
            }
            if let value = value as? QueryDictionaryConvertible {
                result.merge(try value.queryDictionary(), uniquingKeysWith: { (first, _) in first })
            } else if let value = value as? Bool {
                result["\(label)"] = "\(value)"
            } else if let value = value as? String {
                result["\(label)"] = "\(value)"
            } else if let value = value as? UInt {
                result["\(label)"] = "\(value)"
            } else if let value = value as? CustomDate {
                result["\(label)"] = value.stringValue
            } else {
                throw QueryDictionaryConvertibleError.unknownPropertyType(value)
            }
        }
        if let keys = renamePropertyKeys {
            result = result.replaceKeys(oldAndNewKeys: keys)
        }
        return result
    }
    
    func unwrappedQueryDictionary() -> [String: String] {
        return (try? queryDictionary()) ?? [:]
    }
    
    var renamePropertyKeys: [String: String]? { return nil }
}

extension Dictionary where Key == String
{
    /// Rename the keys of this dictionary. Each key/value pair represents an old key/new key.
    func replaceKeys(oldAndNewKeys: [String: String]) -> Dictionary {
        var newDic = self
        for key in oldAndNewKeys.keys {
            if let value = newDic[key], let newKey = oldAndNewKeys[key] {
                newDic[key] = nil
                newDic[newKey] = value
            }
        }
        return newDic
    }
}
