
import Foundation
import os

enum TaskListViewEvent
{
    // user wants to add another task
    case clickedPlus
    
    // user clicked a task
    case clickedRow(indexPath: IndexPath, model: RowModel)
    
    // user requested logout
    case clickedLogout
    
    // the view is ready to receive data
    case viewIsReady
}

enum TaskListViewUpdate {
    case load(sections: [Section<RowModel>]) // update data on the view
}

extension TaskListViewController: Injectable
{
    func input(_ input: TaskListViewUpdate) {
        DispatchQueue.main.async {
            switch input {
            case .load(let sections):
                self.flatCollectionVC.input(.load(sections: sections))
            }
        }
    }
}

extension TaskListInteractor: Injectable
{
    func input(_ input: TaskListViewEvent){
        switch input {
        case .clickedPlus:
            environment.coordinator.present(screen: .taskCreate)
        case .clickedRow(let indexPath, _):
            let todoItem = projectItems[indexPath.section].items[indexPath.row]
            environment.coordinator.show(screen: .taskDetail(todoItem))
        case .clickedLogout:
            environment.coordinator.show(screens: [.login])
        case .viewIsReady:
            downloadTasks()
        }
    }
}

func build() -> TaskListViewController {
    let interactor = TaskListInteractor()
    let controller = TaskListViewController()
    interactor.output = { [unowned controller] update in
        controller.input(update)
    }
    controller.output = { event in
        interactor.input(event)
    }
    controller.flatCollectionVC.previewDelegate = PreviewDelegate { indexPath in
        return interactor.taskDetailController(for: indexPath)
    }
    return controller
}
