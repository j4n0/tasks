
import UIKit

final class TodoCellView: UIView
{
    private let label = UILabel()
    
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
        addSubview(label)
        
        let views: [String: UIView] = ["label" : label]
        views.values.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        for constraint in [
            "H:|-20-[label]|",
            "V:|[label]|"
            ] {
                addConstraints(NSLayoutConstraint.constraints(withVisualFormat: constraint, options: [], metrics: nil, views: views))
        }
    }
}

extension TodoCellView: CellViewType
{
    typealias T = TodoModel
    
    func configure(cellModel: T) {
        label.text = cellModel.title
    }
}
