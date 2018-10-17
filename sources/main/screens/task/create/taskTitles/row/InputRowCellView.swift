
import UIKit

final class InputRowCellView: UIView
{
    lazy var textField = UITextField().then {
        $0.font = UIFont(name: "HelveticaNeue-Light", size: UIFont.preferredFont(forTextStyle: .body).pointSize)
        $0.placeholder = "New Row"
        $0.delegate = self
    }
    let separator = UIView().then {
        $0.backgroundColor = UIColor(hexString: "#e0e3e6")
    }
    
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
            "V:|[textField][separator(1)]|"
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
        textField.tag = cellModel.rowNumber
    }
}

extension InputRowCellView: UITextFieldDelegate
{
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        let inputRow = InputRowModel(title: textField.text ?? "", rowNumber: textField.tag)
        NotificationCenter.default.post(name: Notification.Name.taskTitleBeganEditing, object: inputRow)
    }
    public func textFieldDidEndEditing(_ textField: UITextField) {
        let inputRow = InputRowModel(title: textField.text ?? "", rowNumber: textField.tag)
        NotificationCenter.default.post(name: Notification.Name.taskTitleEndEditing, object: inputRow)
    }
}

extension Notification.Name
{
    static var taskTitleBeganEditing: Notification.Name {
        return .init(rawValue: "InputRowCellView.taskTitleBeginEditing")
    }
    static var taskTitleEndEditing: Notification.Name {
        return .init(rawValue: "InputRowCellView.taskTitleEndEditing")
    }
}
