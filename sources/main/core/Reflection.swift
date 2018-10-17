
import Foundation

struct Reflection
{
    static func reflectFields<T>(item: Any) -> [String: T?] {
        var fields = [String: T]()
        let mirror = Mirror(reflecting: item)
        for (_, attr) in mirror.children.enumerated() {
            if let property_name = attr.label {
                if let optional = attr.value as? OptionalProtocol {
                    if let value = optional as? T {
                        fields["\(property_name)"] = value
                    } else {
                        // skipping nil attr.value
                    }
                } else if let value = attr.value as? T {
                    fields["\(property_name)"] = value
                }
            }
        }
        return fields
    }
}
