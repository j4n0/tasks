
import Foundation

/// Part of AllTasksResponse
public struct TodoItem: Codable
{
    public let id: Int?
    public let canComplete: Bool?
    public let commentsCount: Int?
    public let description: String?
    public let hasReminders: Bool?
    public let hasUnreadComments: Bool?
    public let todoItemPrivate: Int?
    public let content: String?
    public let order: Int?
    public let projectID: Int?
    public let projectName: String?
    public let todoListID: Int?
    public let todoListName: String?
    public let tasklistPrivate: Bool?
    public let tasklistIsTemplate: Bool?
    public let status: String?
    public let companyName: String?
    public let companyID: Int?
    public let creatorID: Int?
    public let creatorFirstname: String?
    public let creatorLastname: String?
    public let completed: Bool?
    public let startDate: String?
    public let dueDateBase: String?
    public let dueDate: String?
    public let createdOn: Date?
    public let lastChangedOn: Date?
    public let position: Int?
    public let estimatedMinutes: Int?
    public let priority: String?
    public let progress: Int?
    public let harvestEnabled: Bool?
    public let parentTaskID: String?
    public let lockdownID: String?
    public let tasklistLockdownID: String?
    public let hasDependencies: Int?
    public let hasPredecessors: Int?
    public let hasTickets: Bool?
    public let tags: [Tag]?
    public let timeIsLogged: String?
    public let attachmentsCount: Int?
    public let responsiblePartyIDS: String?
    public let responsiblePartyID: String?
    public let responsiblePartyNames: String?
    public let responsiblePartyType: String?
    public let responsiblePartyFirstname: String?
    public let responsiblePartyLastname: String?
    public let responsiblePartySummary: String?
    public let predecessors: [Predecessor]?
    public let canEdit: Bool?
    public let viewEstimatedTime: Bool?
    public let creatorAvatarURL: String?
    public let canLogTime: Bool?
    public let userFollowingComments: Bool?
    public let userFollowingChanges: Bool?
    public let dlm: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case canComplete
        case commentsCount = "comments-count"
        case description
        case hasReminders = "has-reminders"
        case hasUnreadComments = "has-unread-comments"
        case todoItemPrivate = "private"
        case content
        case order
        case projectID = "project-id"
        case projectName = "project-name"
        case todoListID = "todo-list-id"
        case todoListName = "todo-list-name"
        case tasklistPrivate = "tasklist-private"
        case tasklistIsTemplate = "tasklist-isTemplate"
        case status
        case companyName = "company-name"
        case companyID = "company-id"
        case creatorID = "creator-id"
        case creatorFirstname = "creator-firstname"
        case creatorLastname = "creator-lastname"
        case completed
        case startDate = "start-date"
        case dueDateBase = "due-date-base"
        case dueDate = "due-date"
        case createdOn = "created-on"
        case lastChangedOn = "last-changed-on"
        case position
        case estimatedMinutes = "estimated-minutes"
        case priority
        case progress
        case harvestEnabled = "harvest-enabled"
        case parentTaskID = "parentTaskId"
        case lockdownID = "lockdownId"
        case tasklistLockdownID = "tasklist-lockdownId"
        case hasDependencies = "has-dependencies"
        case hasPredecessors = "has-predecessors"
        case hasTickets
        case tags
        case timeIsLogged
        case attachmentsCount = "attachments-count"
        case responsiblePartyIDS = "responsible-party-ids"
        case responsiblePartyID = "responsible-party-id"
        case responsiblePartyNames = "responsible-party-names"
        case responsiblePartyType = "responsible-party-type"
        case responsiblePartyFirstname = "responsible-party-firstname"
        case responsiblePartyLastname = "responsible-party-lastname"
        case responsiblePartySummary = "responsible-party-summary"
        case predecessors
        case canEdit
        case viewEstimatedTime
        case creatorAvatarURL = "creator-avatar-url"
        case canLogTime
        case userFollowingComments = "userFollowingComments"
        case userFollowingChanges = "userFollowingChanges"
        case dlm = "DLM"
    }
}
