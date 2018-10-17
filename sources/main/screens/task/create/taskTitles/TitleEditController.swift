
import UIKit

class TitleEditController: NSObject
{
    var rows: [InputRowModel]
    weak var tableDataSource: TableDataSource<InputRowCell>?
    weak var tableView: UITableView?
    @objc dynamic var isValidData: Bool = false
    
    init(rows: [InputRowModel], tableDataSource: TableDataSource<InputRowCell>, tableView: UITableView){
        self.rows = rows
        self.tableDataSource = tableDataSource
        self.tableView = tableView
        self.tableDataSource?.sections = [Section<InputRowModel>(title: "Task titles", rows: rows)]
        super.init()
        observeTaskEdition()
    }
    
    func observeTaskEdition(){
        NotificationCenter.default.addObserver(self, selector: #selector(TitleEditController.titleChanged(_:)), name: NSNotification.Name.taskTitleChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TitleEditController.endEditing(_:)), name: NSNotification.Name.taskTitleEndEditing, object: nil)
    }
    
    @objc func titleChanged(_ notification: Notification){
        if let inputRowModel = notification.object as? InputRowModel {
            titleChanged(rowModel: inputRowModel)
        }
    }
    
    @objc func endEditing(_ notification: Notification){
        if let inputRowModel = notification.object as? InputRowModel {
            endEditing(rowModel: inputRowModel)
        }
    }
    
    func indexOf(uuid: String) -> Int? {
        return rows.firstIndex { $0.uuid == uuid }
    }
    
    func titleChanged(rowModel: InputRowModel){
        // if we are editing the last blank row, we add one more to indicate it’s possible to keep adding
        guard let index = indexOf(uuid: rowModel.uuid), !rowModel.title.isEmpty else {
            updateIsValidData()
            return
        }
        let isLastRow = rows.count == index + 1
        if isLastRow {
            insert(row: rowModel)
        }
        isValidData = true
    }
    
    func endEditing(rowModel: InputRowModel){
        // we update the text entered by the user in our row model
        guard let index = indexOf(uuid: rowModel.uuid) else { return }
        update(row: rowModel)
        // if this row is not the last and it is empty we remove it
        let isLastRow = rows.count == index + 1
        let isEmpty = rowModel.title.count == 0
        if !isLastRow && isEmpty {
            remove(row: rowModel)
        }
        // validate data
        updateIsValidData()
    }
    
    func updateIsValidData(){
        isValidData = rows.firstIndex { !$0.title.isEmpty } != nil
        print(isValidData)
    }
    
    func insert(row: InputRowModel){
        let newRow = InputRowModel(title: "", uuid: UUID().uuidString)
        rows.append(newRow)
        updateDataSource(rows: rows)
        tableView?.insertRows(at: [IndexPath(row: rows.count - 1, section: 0)], with: UITableView.RowAnimation.fade)
    }
    
    func remove(row: InputRowModel){
        guard let index = indexOf(uuid: row.uuid) else { return }
        rows.remove(at: index)
        updateDataSource(rows: rows)
        tableView?.deleteRows(at: [IndexPath(row: index, section: 0)], with: UITableView.RowAnimation.fade)
    }
    
    func update(row: InputRowModel){
        guard let index = indexOf(uuid: row.uuid) else { return }
        rows.remove(at: index)
        rows.insert(row, at: index)
        updateDataSource(rows: rows)
    }
    
    func updateDataSource(rows: [InputRowModel]){
        tableDataSource?.sections = [Section<InputRowModel>(title: "Task titles", rows: rows)]
    }
}
