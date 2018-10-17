
import Foundation

extension Array where Element == ProjectItems {
    
    init(todoItems: [TodoItem])
    {
        let itemsByProjectName = type(of: self).mapItemsByProjectName(todoItems: todoItems)
        let projectItems = itemsByProjectName.map({ (key: String, value: [TodoItem]) -> ProjectItems in
            return ProjectItems(projectName: key, items: value)
        })
        self.init(projectItems)
    }
    
    static func mapItemsByProjectName(todoItems: [TodoItem]) -> [String: [TodoItem]] {
        var dictionary = [String: [TodoItem]]()
        for item in todoItems {
            let projectName = item.projectName ?? ""
            if dictionary[projectName] == nil {
                dictionary[projectName] = [TodoItem]()
            }
            dictionary[projectName]?.append(item)
        }
        return dictionary
    }
}
