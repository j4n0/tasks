
import os
import UIKit

class TasksViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.brown
        allTasks()
    }
    
    func allTasks(){
        environment.teamworkClient?.allTasks { (result) in
            switch result {
            case .success(let allTasksResponse):
                print(allTasksResponse)
            case .error(let e):
                os_log("Downloading all tasks: %@", e.localizedDescription)
            }
        }
    }
}
