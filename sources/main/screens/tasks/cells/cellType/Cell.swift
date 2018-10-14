
import UIKit

class Cell<C: UIView & CellViewType>: UICollectionViewCell
{
    private let cellView: C
    
    override init(frame: CGRect){
        cellView = C()
        super.init(frame: frame)
        contentView.addSubview(cellView)
        cellView.frame = bounds
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Cell: CellType
{
    typealias T = C.T
    
    func configure(cellModel: T) {
        cellView.configure(cellModel: cellModel)
    }
    
    static func identifier()->String {
        return String(describing: type(of: self))
    }
}
