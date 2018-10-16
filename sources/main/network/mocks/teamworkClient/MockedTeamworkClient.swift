
import Foundation
import os

class MockedTeamworkClient: TeamworkClient
{
    var mockedSession = MockURLSession()
    
    init(){
        let baseURL = URL(string: "http://unused")!
        super.init(session: mockedSession, baseURL: baseURL)
    }
    
    func data(forResource name: String, ofType type: String) -> Data? {
        guard let url = Bundle.main.url(forResource: name, withExtension: type) else { return nil }
        guard let data = try? Data(contentsOf: url) else {
            os_log("Nothing found for resource %@.%@", name, type)
            return nil
        }
        return data
    }
    
    override func allTasks(completion: @escaping ApiResultCompletion<AllTasksResponse>) {
        mockedSession.nextData = data(forResource: "allTasksResponse", ofType: "json")
        super.allTasks(completion: completion)
    }
    
    override func me(query: MeQuery?, completion: @escaping ApiResultCompletion<MeResponse>) {
        mockedSession.nextData = data(forResource: "meResponse", ofType: "json")
        super.me(completion: completion)
    }
    
    override func taskLists(query: TaskListsQuery?, completion: @escaping ApiResultCompletion<TaskListsResponse>) {
        mockedSession.nextData = data(forResource: "taskListsResponse", ofType: "json")
        super.taskLists(completion: completion)
    }
    
    /// Quickly add multiple tasks
    /// https://developer.teamwork.com/projects/tasks/quickly-add-multiple-tasks
    override func quickadd(projectId: String, tasks: QuickAddBody, completion: @escaping ApiResultCompletion<QuickAddResponse>) {
        mockedSession.nextData = data(forResource: "quickaddResponse", ofType: "json")
        super.quickadd(projectId: projectId, tasks: tasks, completion: completion)
    }
    
    /// Retrieves all accessible projects. Default returns your active projects.
    /// https://developer.teamwork.com/projects/projects/retrieve-all-projects
    override func projects(query: ProjectsQuery?, completion: @escaping ApiResultCompletion<ProjectsResponse>) {
        mockedSession.nextData = data(forResource: "projectsResponse", ofType: "json")
        super.projects(completion: completion)
    }
}
