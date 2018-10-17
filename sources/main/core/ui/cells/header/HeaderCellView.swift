
import UIKit

final class HeaderCellView: UIView
{
    private let label = UILabel().then {
        $0.font = UIFont(name: "HelveticaNeue-Medium", size: UIFont.preferredFont(forTextStyle: .title1).pointSize)
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

extension HeaderCellView: CellViewType
{
    typealias T = String
    
    func configure(cellModel: T) {
        label.text = cellModel
    }
}
