
import UIKit

final class TableDataSource<C: CellType & UITableViewCell>: NSObject, UITableViewDataSource
{
    var sections = [Section<C.T>]()
    
    init(tableView: UITableView){
        tableView.register(C.self, forCellReuseIdentifier: C.identifier())
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: C.identifier(), for: indexPath)
        if let cell = cell as? C {
            let cellModel = sections[indexPath.section].rows[indexPath.row]
            cell.configure(cellModel: cellModel)
        }
        return cell
    }
}
