import Foundation

final public class QuickAddBody: Codable
{
    public var content: String
    public var tasklistId: Int?
    public var creatorId: Int?
    public var notify: Bool?
    public var quickAddBodyPrivate: Bool?
    public var todoItem: QuickAddItem?
    
    init(content: String){
        self.content = content
    }
    
    enum CodingKeys: String, CodingKey {
        case content
        case tasklistId = "tasklistId"
        case creatorId = "creator-id"
        case notify
        case quickAddBodyPrivate = "private"
        case todoItem = "todo-item"
    }
}

public final class QuickAddItem: Codable
{
    public var responsiblePartyId: String?
    public var startDate: String?
    public var dueDate: String?
    public var priority: String?
    public var description: String?
    
    enum CodingKeys: String, CodingKey {
        case responsiblePartyId = "responsible-party-id"
        case startDate = "start-date"
        case dueDate = "due-date"
        case priority
        case description
    }
}
