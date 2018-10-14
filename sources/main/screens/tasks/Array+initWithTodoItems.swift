
import Foundation

extension Array where Element == Section<TodoModel>
{
    init(todoItems: [TodoItem]){
        let dictionary = Array.dictionaryByProjectName(todoItems: todoItems)
        let sections = Array.sectionPerProject(dictionaryByProjectName: dictionary)
        self.init(sections)
    }
    
    private static func dictionaryByProjectName(todoItems: [TodoItem]) -> [String: [TodoModel]] {
        var sectionsDic = [String: [TodoModel]]()
        for item in todoItems {
            let projectName = item.projectName ?? ""
            let title = item.content ?? ""
            let model = TodoModel(title: title)
            if sectionsDic[projectName] == nil {
                sectionsDic[projectName] = [TodoModel]()
            }
            sectionsDic[projectName]?.append(model)
        }
        return sectionsDic
    }
    
    private static func sectionPerProject(dictionaryByProjectName: [String: [TodoModel]]) -> [Section<TodoModel>] {
        var sections = [Section<TodoModel>]()
        for key in dictionaryByProjectName.keys {
            dictionaryByProjectName[key].flatMap {
                sections.append(Section(title: key, rows: $0))
            }
        }
        return sections
    }
}
