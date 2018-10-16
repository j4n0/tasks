import Foundation

/// Response to GET /tasklists.json - Get all task lists.
public struct TaskListsResponse: Codable
{
    public let status: String?
    public let tasklists: [Tasklist]?
    
    enum CodingKeys: String, CodingKey {
        case tasklists
        case status = "STATUS"
    }
}

/// Part of TaskListsResponse.
public struct Tasklist: Codable
{
    public let id: String?
    public let name: String?
    public let description: String?
    public let position: Int?
    public let projectId: String?
    public let projectName: String?
    public let updatedAfter: Date?
    public let tasklistPrivate: Bool?
    public let isTemplate: Bool?
    public let tags: [String]?
    public let milestoneId: String?
    public let pinned: Bool?
    public let complete: Bool?
    public let uncompletedCount: Int?
    public let status: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case position
        case projectId = "projectId"
        case projectName
        case updatedAfter
        case tasklistPrivate = "private"
        case isTemplate
        case tags
        case milestoneId = "milestone-id"
        case pinned
        case complete
        case uncompletedCount = "uncompleted-count"
        case status
    }
}
