
import UIKit

class TodoCell: Cell<TodoCellView>
{
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundView = UIView(frame: self.bounds)
        backgroundView?.backgroundColor = .white
        selectedBackgroundView = UIView(frame: self.bounds)
        selectedBackgroundView?.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.96, alpha: 1.0)
    }
}
