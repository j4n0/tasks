
import Foundation
import os

enum TasksInteractorMessage {
    case allTasks, clicked(TodoModel)
}

protocol TasksInteractorType: class {
    var tasksViewController: TasksViewControllerType? { get set }
    func message(_ msg: TasksInteractorMessage)
}

class TasksInteractor: TasksInteractorType
{
    weak var tasksViewController: TasksViewControllerType?
    
    func message(_ msg: TasksInteractorMessage){
        switch msg {
        case .allTasks: allTasks()
        case .clicked(let todoModel): print(todoModel)
        }
    }
    
    func allTasks(){
        environment.teamworkClient?.allTasks { (result) in
            switch result {
            case .success(let allTasksResponse):
                let sections = [Section<TodoModel>](todoItems: allTasksResponse.todoItems ?? [TodoItem]())
                self.tasksViewController?.reloadData(sections: sections)
            case .error(let e):
                os_log("Downloading all tasks: %@", e.localizedDescription)
            }
        }
    }
}
