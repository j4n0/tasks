
import Foundation

extension Array where Element == Section<RowModel>
{
    init(todoItems: [TodoItem]){
        let dictionary = Array.dictionaryByProjectName(todoItems: todoItems)
        let sections = Array.sectionPerProject(dictionaryByProjectName: dictionary)
        self.init(sections)
    }
    
    private static func dictionaryByProjectName(todoItems: [TodoItem]) -> [String: [RowModel]] {
        var sectionsDic = [String: [RowModel]]()
        for item in todoItems {
            let projectName = item.projectName ?? ""
            let title = item.content ?? ""
            let model = RowModel(title: title)
            if sectionsDic[projectName] == nil {
                sectionsDic[projectName] = [RowModel]()
            }
            sectionsDic[projectName]?.append(model)
        }
        return sectionsDic
    }
    
    private static func sectionPerProject(dictionaryByProjectName: [String: [RowModel]]) -> [Section<RowModel>] {
        var sections = [Section<RowModel>]()
        for key in dictionaryByProjectName.keys {
            dictionaryByProjectName[key].flatMap {
                sections.append(Section(title: key, rows: $0))
            }
        }
        return sections
    }
}
