
import Foundation

class MockedTeamworkClient: TeamworkClient
{
    var mockedSession = MockURLSession()
    
    init(){
        let baseURL = URL(string: "http://unused")!
        super.init(session: mockedSession, baseURL: baseURL)
    }
    
    func data(forResource name: String, ofType type: String) -> Data? {
        guard let url = Bundle.main.url(forResource: name, withExtension: type) else { return nil }
        return try? Data(contentsOf: url)
    }
    
    override func allTasks(completion: @escaping ApiResultCompletion<AllTasksResponse>) {
        mockedSession.nextData = data(forResource: "allTasksResponse", ofType: "json")
        super.allTasks(completion: completion)
    }
    
    override func taskLists(query: TaskListsQuery?, completion: @escaping ApiResultCompletion<TaskListsResponse>) {
        mockedSession.nextData = data(forResource: "taskListsResponse", ofType: "json")
        super.taskLists(completion: completion)
    }
    
    override func quickadd(projectId: String, tasks: QuickAddBody, completion: @escaping ApiResultCompletion<QuickAddResponse>) {
        mockedSession.nextData = data(forResource: "quickaddResponse", ofType: "json")
        super.quickadd(projectId: projectId, tasks: tasks, completion: completion)
    }
    
    override func projects(query: ProjectsQuery?, completion: @escaping ApiResultCompletion<ProjectsResponse>) {
        mockedSession.nextData = data(forResource: "projectsResponse", ofType: "json")
        super.projects(completion: completion)
    }
}
