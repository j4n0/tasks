
import os
import UIKit

class TaskTitlesViewController: UIViewController
{
    private var tableView = UITableView()
    lazy var tableDataSource = TableDataSource<InputRowCell>(tableView: self.tableView)
    var rows: [InputRowModel]
    
    init(rows: [InputRowModel]){
        self.rows = rows
        super.init(nibName: nil, bundle: nil)
        tableDataSource.sections = [Section<InputRowModel>(title: "Task titles", rows: rows)]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        layoutTable(tableView: tableView, onView: view)
        tableView.dataSource = tableDataSource
        super.viewDidLoad()
        observeTaskEdition()
    }
    
    func beginEditing(){
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? InputRowCell {
            cell.cellView.textField.becomeFirstResponder()
        }
    }
    
    func observeTaskEdition(){
        NotificationCenter.default.addObserver(self, selector: #selector(TaskTitlesViewController.beganEditing(_:)), name: NSNotification.Name.taskTitleBeganEditing, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TaskTitlesViewController.endEditing(_:)), name: NSNotification.Name.taskTitleEndEditing, object: nil)
    }
    
    @objc func beganEditing(_ notification: Notification){
        if let inputRowModel = notification.object as? InputRowModel {
            let isLastRow = rows.count == inputRowModel.rowNumber + 1
            if isLastRow {
                print("Add another") // 🙄 this should happen when there are characters in the field
                rows.append(InputRowModel(title: "", rowNumber: rows.count))
                tableDataSource.sections = [Section<InputRowModel>(title: "Task titles", rows: rows)]
                tableView.insertRows(at: [IndexPath(row: rows.count - 1, section: 0)], with: UITableView.RowAnimation.fade)
            }
        }
    }
    
    @objc func endEditing(_ notification: Notification){
        if let inputRowModel = notification.object as? InputRowModel {
            // update this row
            let index = inputRowModel.rowNumber
            rows.remove(at: index)
            rows.insert(inputRowModel, at: index)
            // remove last row if it is empty and there are more rows
            let isLastRow = rows.count == index + 1
            let isEmpty = inputRowModel.title.count == 0
            if !isLastRow && isEmpty {
                print("Remove row \(index)")
                rows.remove(at: index)
                tableDataSource.sections = [Section<InputRowModel>(title: "Task titles", rows: rows)]
                tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: UITableView.RowAnimation.fade)
            }
        }
    }
}

extension TaskTitlesViewController
{
    func layoutTable(tableView: UITableView, onView: UIView)
    {
        view.backgroundColor = .green
        view.addSubview(tableView)
        let views: [String:AnyObject] = [
            "tableView":tableView,
            "parent": view,
            "topGuide": view.safeAreaLayoutGuide.topAnchor ,
            "bottomGuide": view.safeAreaLayoutGuide.bottomAnchor]
        tableView.translatesAutoresizingMaskIntoConstraints = false
        for constraint in [
            "V:|[tableView]|",
            "H:|[tableView]|",
            ] {
                view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: constraint, options: [], metrics: nil, views: views))
        }
    }
}
