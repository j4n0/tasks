
import os
import UIKit

class TitleEditViewController: UIViewController
{
    private var tableView = UITableView()
    lazy var tableDataSource = TableDataSource<InputRowCell>(tableView: self.tableView)
    var titleEditController: TitleEditController!
    
    init(){
        super.init(nibName: nil, bundle: nil)
        let rows = [InputRowModel(title: "", uuid: UUID().uuidString)]
        titleEditController = TitleEditController(rows: rows, tableDataSource: tableDataSource, tableView: tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        layout()
        tableView.dataSource = tableDataSource
        super.viewDidLoad()
    }
    
    func layout(){
        view.backgroundColor = .green
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.pinEdgesToSafeAreas()
    }
    
    func beginEditing(){
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? InputRowCell {
            cell.cellView.textField.becomeFirstResponder()
        }
    }
}
