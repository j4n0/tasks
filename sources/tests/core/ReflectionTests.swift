
import XCTest
@testable import Tasks

final class ReflectionTests: XCTestCase
{
    func testEncodeResponse(){
        let allTasks: AllTasksResponse? = XCTestCase.decodeJsonFile(resource: "allTasksResponse", withExtension: "json")
        guard let item = allTasks?.todoItems?.first else {
            return
        }
        let stringKeyAnyValue: [String: Any?] = Reflection.reflectFields(item: item)
        let stringKeyStringValue = Dictionary(uniqueKeysWithValues: stringKeyAnyValue.compactMap { (key: String, value: Any?) -> (String, String) in
            if let unwrapValue = value {
                if let tags = value as? [Tag] {
                    let names = tags.compactMap({ (tag) -> String? in return tag.name }).joined(separator: ",")
                    return (key, "\(names)".lowercased())
                } else {
                    return (key, "\(unwrapValue)".lowercased())
                }
            }
            return (key, "")
        })
        print(stringKeyStringValue)
    }
}
