
import Foundation

public class TeamworkClient: ApiClient
{
    init?(authentication: Authentication?){
        guard let authentication = authentication else { return nil }
        let session = TeamworkClient.createSession(authorizationHeader: authentication.authorizationHeader)
        guard let baseURL = URL(string: "https://" + authentication.company + ".teamwork.com") else {
            return nil
        }
        super.init(session: session, baseURL: baseURL)
    }
    
    override init(session: URLSessionProtocol, baseURL: URL){
        super.init(session: session, baseURL: baseURL)
    }
    
    static func createSession(authorizationHeader: [String: String]) -> URLSession {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = authorizationHeader
        config.httpAdditionalHeaders?["Accept"] = "application/json"
        return URLSession(configuration: config)
    }
    
    /// Get all tasks across all projects
    /// https://developer.teamwork.com/projects/tasks/get-all-tasks-across-all-projects
    func allTasks(completion: @escaping ApiResultCompletion<AllTasksResponse>) {
        fetch(resource: "/tasks.json") { (result: ApiResult<AllTasksResponse>) in
            self.complete(completion: completion, result: result)
        }
    }
    
    /// Get all task lists for a project
    /// https://developer.teamwork.com/projects/task-lists/get-all-task-lists-for-a-project
    func taskLists(query: TaskListsQuery? = nil, completion: @escaping ApiResultCompletion<TaskListsResponse>) {
        let resource = Resource(path: "/tasklists.json", query: query?.unwrappedQueryDictionary() ?? [:])
        fetch(resource: resource) { (result: ApiResult<TaskListsResponse>) in
            self.complete(completion: completion, result: result)
        }
    }
    
    /// Quickly add multiple tasks
    /// https://developer.teamwork.com/projects/tasks/quickly-add-multiple-tasks
    func quickadd(projectId: String, tasks: QuickAddBody, completion: @escaping ApiResultCompletion<AllTasksResponse>) {
        let data = tasks.dumpJSON()?.data(using: .utf8)
        let resource = Resource(path: "/projects/\(projectId)/tasks/quickadd.json", method: .post, httpBody: data)
        fetch(resource: resource) { (result: ApiResult<AllTasksResponse>) in
            self.complete(completion: completion, result: result)
        }
    }
    
    /// Quickly add multiple tasks
    /// https://developer.teamwork.com/projects/tasks/quickly-add-multiple-tasks
    func projects(query: ProjectsQuery? = nil, completion: @escaping ApiResultCompletion<ProjectsResponse>) {
        let resource = Resource(path: "/projects.json", query: query?.unwrappedQueryDictionary() ?? [:])
        fetch(resource: resource) { (result: ApiResult<ProjectsResponse>) in
            self.complete(completion: completion, result: result)
        }
    }
    
    func complete<T>(completion: @escaping ApiResultCompletion<T>, result: ApiResult<T>){
        switch result {
        case .success(_):
            completion(result)
        case .error(let e):
            completion(.error(e))
        }
    }
}
