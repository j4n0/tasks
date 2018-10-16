
import os
import UIKit

class TaskListViewController: UIViewController, Interactable
{
    // Interactable
    typealias Output = TaskListViewEvent
    var output: ((TaskListViewEvent) -> Void) = { event in os_log("Got event %@ but override is missing.", "\(event)") }
    
    lazy var flatCollectionVC = FlatCollectionVC(sections: [], showHeaders: true).then {
        $0.output = { event in
            switch event {
            case .clickedRow(let indexPath, let rowModel): self.output(.clickedRow(indexPath: indexPath, model: rowModel))
            case .viewIsReady: self.output(.viewIsReady)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }

    func layout(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(TaskListViewController.didClickPlus))
        navigationController?.navigationBar.isHidden = false
        add(childController: flatCollectionVC)
        flatCollectionVC.view.pinEdgesToSuperview()
    }
    
    @objc func didClickPlus(){
        self.output(.clickedPlus)
    }
}
