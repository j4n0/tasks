
import os
import UIKit

enum FlatCollectionEvent {
    case clickedRow(indexPath: IndexPath, model: RowModel)
    case viewIsReady
}

enum FlatCollectionUpdate {
    case load(sections: [Section<RowModel>])
}

extension FlatCollectionVC: Injectable
{
    typealias Input = FlatCollectionUpdate
    func input(_ input: FlatCollectionUpdate) {
        switch input {
        case .load(let sections):
            os_log("Reloading data: %d sections", sections.count)
            datasource.sections = sections
            collectionView.reloadData()
        }
    }
}

final class FlatCollectionVC: UIViewController, Interactable
{
    // Interactable
    var output: ((FlatCollectionEvent) -> Void) = { event in os_log("Got event %@ but override is missing.", "\(event)") }
    
    var previewDelegate: PreviewDelegate?
    
    private lazy var collectionView: UICollectionView = {
        let layout = CollectionViewLayout(display: .list)
        layout.headerReferenceSize = showHeaders ? CGSize(width: 0, height: 54) : CGSize.zero 
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(RowCell.self, forCellWithReuseIdentifier: RowCell.identifier())
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCell.identifier())
        collectionView.dataSource = datasource
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private let showHeaders: Bool
    private let datasource = CollectionDataSource<RowCell, HeaderCell>()
    
    init(sections: [Section<RowModel>], showHeaders: Bool){
        self.showHeaders = showHeaders
        super.init(nibName: nil, bundle: nil)
        if sections.count > 0 {
            self.input(.load(sections: sections))
        }
        self.datasource.sections = sections
        os_log("show headers? %d", showHeaders)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = collectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        registerPeekAndPop()
    }
    
    func registerPeekAndPop(){
        if UIApplication.shared.keyWindow?.traitCollection.forceTouchCapability == UIForceTouchCapability.available, previewDelegate != nil {
            registerForPreviewing(with: self, sourceView: view)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output(.viewIsReady)
    }
}

extension FlatCollectionVC: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let rowModel = datasource.sections[indexPath.section].rows[indexPath.row]
        output(.clickedRow(indexPath: indexPath, model: rowModel))
        deselectItem(indexPath: indexPath)
    }
    
    private func deselectItem(indexPath: IndexPath){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(50)) {
            if let selectedRow = self.collectionView.indexPathsForSelectedItems?.first {
                self.collectionView.deselectItem(at: selectedRow, animated: true)
            }
        }
    }
}

extension FlatCollectionVC: UIViewControllerPreviewingDelegate
{
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = collectionView.indexPathForItem(at:location) else { return nil }
        guard let cell = collectionView.cellForItem(at: indexPath) else { return nil }
        guard let controller = previewDelegate?.controllerForIndexPath(indexPath) else {
            return nil
        }
        controller.preferredContentSize = CGSize(width: 0.0, height: 500)
        previewingContext.sourceRect = cell.frame
        return controller
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
}

final class PreviewDelegate: UIResponder
{
    init(controllerForIndexPath: @escaping (IndexPath) -> UIViewController) {
        self.controllerForIndexPath = controllerForIndexPath
    }
    var controllerForIndexPath: (IndexPath) -> UIViewController
}
