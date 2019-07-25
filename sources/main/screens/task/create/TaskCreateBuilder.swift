
import Foundation
import os

enum TaskCreateViewEvent {
    case newRow(row: Int, text: String)
    case removeRow(row: Int)
    case save(tasks: String, tasklist: Tasklist)
    case dismiss
    case viewIsReady
}

enum TaskCreateViewUpdate {
    case tasklist(tasklist: Tasklist) 
}

extension TaskCreateViewController: Injectable
{
    typealias Input = TaskCreateViewUpdate
    func input(_ input: TaskCreateViewUpdate) {
        DispatchQueue.main.async {
            switch input {
                case .tasklist(let tasklist): self.taskCreateView.tasklist = tasklist
            }
        }
    }
}

extension TaskCreateInteractor: Injectable
{
    typealias Input = TaskCreateViewEvent
    func input(_ input: Input){
        switch input {
        case .newRow(let row, let text): os_log("implement create row %d %@", row, text)
        case .removeRow(let row): os_log("implement remove row %d", row)
        case .save(let tasks, let tasklist): save(tasks: tasks, taskList: tasklist)
        case .dismiss: environment.coordinator.dismissWithDiscardAnimation()
        case .viewIsReady:
            updateUserId()
            updateViewWithTaskList()
        }
    }
}

func build() -> TaskCreateViewController {
    let interactor = TaskCreateInteractor()
    let controller = TaskCreateViewController()
    interactor.output = { [unowned controller] update in
        os_log(.debug, log: OSLog.default, "view update: %@", "\(update)")
        controller.input(update)
    }
    controller.output = { event in
        os_log(.debug, log: OSLog.default, "event: %@", "\(event)")
        interactor.input(event)
    }
    return controller
}
