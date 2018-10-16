
import os
import Foundation

class TaskListInteractor: Interactable
{
    // Interactable
    var output: ((TaskListViewUpdate) -> Void) = { event in os_log("Got event %@ but override is missing.", "\(event)") }
    
    // MARK: - Other
    
    func downloadTasks(){
        environment.teamworkClient?.allTasks { (result) in
            switch result {
            case .success(let allTasksResponse):
                let sections = [Section<RowModel>](todoItems: allTasksResponse.todoItems ?? [TodoItem]())
                self.output(.load(sections: sections))
            case .error(let e):
                os_log("Downloading all tasks: %@", e.localizedDescription)
            }
        }
    }
}

