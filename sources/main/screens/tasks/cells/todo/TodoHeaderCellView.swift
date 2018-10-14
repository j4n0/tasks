
import UIKit

final class TodoHeaderCellView: UIView
{
    private let label = UILabel().then {
        $0.font = UIFont.preferredFont(forTextStyle: .headline)
        $0.adjustsFontForContentSizeCategory = true
    }
    
    private let separator = UIView().then {
        $0.backgroundColor = .lightGray
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
        backgroundColor = .white
        addSubview(label)
        addSubview(separator)
        
        let views: [String: UIView] = ["label": label, "separator": separator]
        views.values.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        for constraint in [
            "H:|-20-[label]-20-|",
            "H:|-20-[separator]-20-|",
            "V:|[label][separator(1)]|"
            ] {
                addConstraints(NSLayoutConstraint.constraints(withVisualFormat: constraint, options: [], metrics: nil, views: views))
        }
    }
}

extension TodoHeaderCellView: CellViewType
{
    typealias T = String
    
    func configure(cellModel: T) {
        label.text = cellModel
    }
}
