
import Foundation

/// Response to /tasks.json
public struct AllTasksResponse: Codable
{
    public let status: String?
    public let todoItems: [TodoItem]?
    
    enum CodingKeys: String, CodingKey {
        case status = "STATUS"
        case todoItems = "todo-items"
    }
}
