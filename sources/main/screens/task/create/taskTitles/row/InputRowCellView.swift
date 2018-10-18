
import UIKit

final class InputRowCellView: UIView
{
    lazy var textField = UITextField().then {
        $0.font = UIFont(name: "HelveticaNeue-Light", size: UIFont.preferredFont(forTextStyle: .body).pointSize)
        $0.placeholder = "New Todo"
        $0.delegate = self
    }
    let separator = UIView().then {
        $0.backgroundColor = UIColor(hexString: "#e0e3e6")
    }
    
    var uuid: String?
    
    init() {
        super.init(frame: CGRect.zero)
        initialize()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("unavailable")
    }
    
    private func initialize()
    {
        backgroundColor = .clear
        addSubview(textField)
        addSubview(separator)
        
        let views = enumerateSubViews()
        views.values.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        for constraint in [
            "H:|-20-[textField]-20-|",
            "H:|-20-[separator]-20-|",
            "V:|[textField(40)][separator(1)]|"
            ] {
                addConstraints(NSLayoutConstraint.constraints(withVisualFormat: constraint, options: [], metrics: nil, views: views))
        }
    }
}

extension InputRowCellView: CellViewType
{
    typealias T = InputRowModel
    
    func configure(cellModel: T) {
        textField.text = cellModel.title
        self.uuid = cellModel.uuid
    }
}

extension InputRowCellView: UITextFieldDelegate
{
    public func textFieldDidEndEditing(_ textField: UITextField) {
        guard let uuid = self.uuid else { return }
        let inputRow = InputRowModel(title: textField.text ?? "", uuid: uuid)
        NotificationCenter.default.post(name: Notification.Name.taskTitleEndEditing, object: inputRow)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        guard let uuid = self.uuid else { return true }
        let inputRow = InputRowModel(title: newText, uuid: uuid)
        NotificationCenter.default.post(name: Notification.Name.taskTitleChanged, object: inputRow)
        return true
    }
}

extension Notification.Name
{
    static var taskTitleChanged: Notification.Name {
        return .init(rawValue: "InputRowCellView.taskTitleChanged")
    }
    static var taskTitleEndEditing: Notification.Name {
        return .init(rawValue: "InputRowCellView.taskTitleEndEditing")
    }
}
