
import os
import UIKit

enum CollectionDisplay {
    case inline
    case list
    case grid
}

final class CollectionViewLayout: UICollectionViewFlowLayout
{
    var display: CollectionDisplay = .grid {
        didSet {
            if display != oldValue {
                self.invalidateLayout()
            }
        }
    }
    
    convenience init(display: CollectionDisplay)
    {
        self.init()
        self.display = display
        self.minimumLineSpacing = 0 // minimum spacing to use between lines of items in the grid
        self.minimumInteritemSpacing = 5 // minimum spacing to use between items in the same row
        self.headerReferenceSize = CGSize(width: 0, height: 60) // default sizes to use for section headers
        self.configLayout()
    }
    
    func configLayout()
    {
        guard let collectionView = collectionView else {
            os_log("Collection view not prepared. It is nil. Skipping layout.")
            return
        }
        guard collectionView.frame.width > 0 else {
            os_log("Collection view not prepared. It has 0 width. Skipping layout.")
            return
        }
        os_log("Collection view ready, configuring layout with display %@", "\(display)")
        switch display {
        case .inline:
            self.scrollDirection = .horizontal
            if let collectionView = self.collectionView {
                self.itemSize = CGSize(width: collectionView.frame.width * 0.9, height: 300)
            }
            
        case .grid:
            self.scrollDirection = .vertical
            if let collectionView = self.collectionView {
                let optimisedWidth = (collectionView.frame.width - minimumInteritemSpacing) / 2
                self.itemSize = CGSize(width: optimisedWidth , height: optimisedWidth) // keep as square
            }
            
        case .list:
            self.scrollDirection = .vertical
            if let collectionView = self.collectionView {
                self.itemSize = CGSize(width: collectionView.frame.width , height: 60)
            }
        }
        os_log("layout scrollDirection is %d", scrollDirection.rawValue)
        os_log("layout item size is %@", "\(itemSize)")
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        self.configLayout()
    }
}
