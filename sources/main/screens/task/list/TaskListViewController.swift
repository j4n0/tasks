
import os
import UIKit

final class TaskListViewController: UIViewController, Interactable
{
    var output: ((TaskListViewEvent) -> Void) = { event in os_log("Got event %@ but override is missing.", "\(event)") }
    
    lazy var flatCollectionVC = FlatCollectionVC(sections: [], showHeaders: true).then {
        $0.output = { event in
            switch event {
            case .clickedRow(let indexPath, let rowModel):
                self.output(.clickedRow(indexPath: indexPath, model: rowModel))
            case .viewIsReady: 
                self.output(.viewIsReady)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        observeUpdateTasks()
    }
    
    func layout(){
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(TaskListViewController.logout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(TaskListViewController.didClickPlus))
        navigationController?.navigationBar.isHidden = false
        add(childController: flatCollectionVC)
        flatCollectionVC.view.pinEdgesToSafeAreas()
    }
    
    @objc func didClickPlus(){
        self.output(.clickedPlus)
    }
    
    @objc func logout(){
        self.output(.clickedLogout)
    }
    
    func observeUpdateTasks(){
        NotificationCenter.default.addObserver(self, selector: #selector(TaskListViewController.updateTasks(_:)), name: NSNotification.Name.tasksSaved, object: nil)
    }
    
    @objc func updateTasks(_ notification: Notification){
        self.output(.viewIsReady)
    }
}
