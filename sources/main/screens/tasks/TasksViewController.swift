
import os
import UIKit

protocol TasksViewControllerType: class {
    func reloadData(sections: [Section<TodoModel>])
}

class TasksViewController: UIViewController
{
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: CollectionViewLayout(display: .list))
        collectionView.register(TodoCell.self, forCellWithReuseIdentifier: TodoCell.identifier())
        collectionView.register(TodoHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TodoHeaderCell.identifier())
        collectionView.dataSource = datasource
        collectionView.delegate = self
        return collectionView
    }()
    
    private let datasource = CollectionDataSource<TodoCell, TodoHeaderCell>()
    private var interactor: TasksInteractorType
    
    init(interactor: TasksInteractorType){
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        interactor.tasksViewController = self
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
        interactor.message(.allTasks)
    }
}

extension TasksViewController: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let todoModel = datasource.sections[indexPath.section].rows[indexPath.row]
        interactor.message(.clicked(todoModel))
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

extension TasksViewController: TasksViewControllerType
{
    func reloadData(sections: [Section<TodoModel>]){
        self.datasource.sections = sections
        self.collectionView.reloadData()
    }
}
