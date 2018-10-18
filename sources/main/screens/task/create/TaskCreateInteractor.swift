
import os
import Foundation

final class TaskCreateInteractor: Interactable
{
    var taskCreateModel = TaskCreateModel()
    
    var output: ((TaskCreateViewUpdate) -> Void) = { event in os_log("Got event %@ but override is missing.", "\(event)") }
    
    func updateViewWithTaskList() {
        environment.teamworkClient?.taskLists { result in
            guard case let .success(tasklistResponse) = result,
                let taskLists = tasklistResponse.tasklists,
                let tasklist = taskLists.first else
            {
                return
            }
            self.taskCreateModel.taskLists = taskLists
            self.taskCreateModel.selectedTaskList = 0
            self.output(.tasklist(tasklist: tasklist))
        }
    }
    
    func updateUserId(){
        environment.teamworkClient?.me { result in
            guard case let .success(meResponse) = result, let id = meResponse.person?.id, let userId = UInt(id) else {
                return
            }
            self.taskCreateModel.userId = userId
        }
    }
    
    
    func save(tasks: String, taskList: Tasklist) {
        guard
            let userId = taskCreateModel.userId,
            let body = type(of: self).createQuickAddBody(tasks: tasks, creatorId: Int(userId), taskList: taskList),
            let projid = taskList.projectId
        else {
            return
        }
        environment.teamworkClient?.quickadd(projectId: projid, tasks: body, completion: { result in
            guard case let .success(quickAddResponse) = result else {
                return
            }
            os_log("%@", "\(quickAddResponse)")
            NotificationCenter.default.post(name: Notification.Name.tasksSaved, object: nil)
            environment.coordinator.dismissWithSuccess()
        })
    }
    
    static func createQuickAddBody(tasks: String, creatorId: Int, taskList: Tasklist) -> QuickAddBody? {
        guard let id = taskList.id, let tasklistId = Int(id) else {
            os_log("The tasklist id doesn’t contain an integer. It was %@", "\(taskList.id ?? "nil")")
            return nil
        }
        let body = QuickAddBody(content: tasks)
        body.tasklistId = tasklistId
        body.notify = false
        body.quickAddBodyPrivate = false
        body.creatorId = creatorId
        let todoItem = QuickAddItem()
        todoItem.responsiblePartyId = "0"
        todoItem.startDate = ""
        todoItem.dueDate = ""
        todoItem.priority = ""
        todoItem.description = ""
        body.todoItem = todoItem
        return body
    }
    
}

final class TaskCreateModel
{
    var taskLists = [Tasklist]()
    var selectedTaskList: UInt?
    var tasks = [String]()
    var userId: UInt?
}

extension Notification.Name
{
    static var tasksSaved: Notification.Name {
        return .init(rawValue: "TaskCreateInteractor.tasksSaved")
    }
}
