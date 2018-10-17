
import Foundation

extension Array where Element == Section<RowModel> {
    
    init(projectItems: [ProjectItems])
    {
        let sections = projectItems.map { (projItem) -> Section<RowModel> in
            let rows = projItem.items.map { RowModel(title: $0.content ?? "") }
            return Section(title: projItem.projectName, rows: rows)
        }
        self.init(sections)
    }
}
