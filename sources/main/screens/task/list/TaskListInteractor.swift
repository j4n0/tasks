
import os
import Foundation

struct ProjectItems {
    let projectName: String
    let items: [TodoItem]
}

class TaskListInteractor: Interactable
{
    // Interactable
    var output: ((TaskListViewUpdate) -> Void) = { event in os_log("Got event %@ but override is missing.", "\(event)") }
    
    var projectItems = [ProjectItems]() {
        didSet {
            let sections = [Section<RowModel>](projectItems: projectItems)
            output(.load(sections: sections))
        }
    }
    
    // MARK: - Other
    
    func downloadTasks(){
        environment.teamworkClient?.allTasks { (result) in
            switch result {
            case .success(let allTasksResponse):
                if let todoItems = allTasksResponse.todoItems {
                    self.projectItems = [ProjectItems](todoItems: todoItems)
                }
            case .error(let e):
                os_log("Downloading all tasks: %@", e.localizedDescription)
            }
        }
    }
    
    func controllerForIndexPath(indexPath: IndexPath) -> TaskDetailViewController {
        let todoItem = projectItems[indexPath.section].items[indexPath.row]
        return TaskDetailViewController(todoItem: todoItem)
    }
}
