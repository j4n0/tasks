
import UIKit

final class RowCellView: UIView
{
    private let label = UILabel().then {
        $0.font = UIFont(name: "HelveticaNeue-Light", size: UIFont.preferredFont(forTextStyle: .body).pointSize)
    }
    private let separator = UIView().then {
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
        addSubview(label)
        addSubview(separator)
        
        let views = enumerateSubViews()
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

extension RowCellView: CellViewType
{
    typealias T = RowModel
    
    func configure(cellModel: T) {
        label.text = cellModel.title
    }
}
