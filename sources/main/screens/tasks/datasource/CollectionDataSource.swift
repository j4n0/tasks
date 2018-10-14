
import UIKit

class CollectionDataSource<C: CellType, H: CellType>: NSObject, UICollectionViewDataSource
{
    var sections = [Section<C.T>]()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: C.identifier(), for: indexPath)
        if let cell = cell as? C {
            let cellModel = sections[indexPath.section].rows[indexPath.row]
            cell.configure(cellModel: cellModel)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: H.identifier(), for: indexPath)
            if let cell = cell as? H, let cellModel = sections[indexPath.section].title as? H.T {
                cell.configure(cellModel: cellModel)
            }
            return cell
        }
        return UICollectionReusableView()
    }
}
