import Foundation

public class QuickAddBody: Codable
{
    public var content: String
    public var tasklistID: Int?
    public var creatorID: Int?
    public var notify: Bool?
    public var quickAddBodyPrivate: Bool?
    public var todoItem: QuickAddItem?
    
    init(content: String){
        self.content = content
    }
    
    enum CodingKeys: String, CodingKey {
        case content
        case tasklistID = "tasklistId"
        case creatorID = "creator-id"
        case notify
        case quickAddBodyPrivate = "private"
        case todoItem = "todo-item"
    }
}

public class QuickAddItem: Codable
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
