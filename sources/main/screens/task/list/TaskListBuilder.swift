
import Foundation
import os

enum TaskListViewEvent {
    // user wants to add another task
    case clickedPlus
    // user clicked a task
    case clickedRow(indexPath: IndexPath, model: RowModel)
    // the view is ready to receive data
    case viewIsReady
}

enum TaskListViewUpdate {
    case load(sections: [Section<RowModel>]) // update data on the view
}

extension TaskListViewController: Injectable
{
    typealias Input = TaskListViewUpdate
    func input(_ input: TaskListViewUpdate) {
        DispatchQueue.main.async {
            switch input {
            case .load(let sections): self.flatCollectionVC.input(.load(sections: sections))
            }
        }
    }
}

extension TaskListInteractor: Injectable
{
    typealias Input = TaskListViewEvent
    func input(_ input: Input){
        switch input {
        case .clickedPlus: environment.coordinator.show(screen: .taskEdit)
        case .clickedRow(let indexPath, let model): os_log("%@", "\(indexPath) \(model)")
        case .viewIsReady: downloadTasks()
        }
    }
}

func build() -> TaskListViewController {
    let interactor = TaskListInteractor()
    let controller = TaskListViewController()
    interactor.output = { update in
        controller.input(update)
    }
    controller.output = { event in
        interactor.input(event)
    }
    return controller
}
