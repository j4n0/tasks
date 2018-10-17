
import UIKit

class TaskDetailViewController: UIViewController
{
    let todoItem: TodoItem
    
    init(todoItem: TodoItem){
        self.todoItem  = todoItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var flatCollectionVC = FlatCollectionVC(sections: [], showHeaders: true).then {
        $0.output = { event in
            switch event {
            case .clickedRow(let indexPath, let rowModel): ()
            case .viewIsReady:
                let title = self.todoItem.content ?? ""
                let sections = [Section(title: title, rows: self.todoItem.mapToRows())]
                self.flatCollectionVC.input(.load(sections: sections))
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    func layout(){
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = false
        add(childController: flatCollectionVC)
        flatCollectionVC.view.pinEdgesToSafeAreas()
    }
}

private extension TodoItem
{
    func mapToRows() -> [RowModel] {
        return dictionaryOfPropertyValue().map { (key: String, value: String) in RowModel(title: "\(key): \(value)") }
    }
    
    func dictionaryOfPropertyValue() -> [String: String]
    {
        let stringKeyAnyValue: [String: Any?] = Reflection.reflectFields(item: self)
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
        return stringKeyStringValue
    }
}
