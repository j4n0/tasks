
import UIKit

class TableCell<C: UIView & CellViewType>: UITableViewCell
{
    let cellView: C
    
    convenience init(){
        self.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: TableCell.identifier())
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        cellView = C()
        super.init(style: style, reuseIdentifier: TableCell.identifier())
        contentView.addSubview(cellView)
        cellView.pinEdgesToSuperview()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TableCell: CellType
{
    typealias T = C.T
    
    func configure(cellModel: T) {
        cellView.configure(cellModel: cellModel)
    }
    
    static func identifier()->String {
        return String(describing: type(of: self))
    }
}
