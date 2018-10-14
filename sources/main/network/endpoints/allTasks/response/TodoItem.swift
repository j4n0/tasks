
import Foundation

/// Part of AllTasksResponse
public struct TodoItem: Codable
{
    public let attachmentsCount: Int?
    public let canComplete: Bool?
    public let canEdit: Bool?
    public let canLogTime: Bool?
    public let commentsCount: Int?
    public let companyID: Int?
    public let companyName: String?
    public let completed: Bool?
    public let content: String?
    public let createdOn: Date?
    public let creatorAvatarURL: String?
    public let creatorFirstname: String?
    public let creatorID: Int?
    public let creatorLastname: String?
    public let description: String?
    public let dlm: Int?
    public let dueDate: String?
    public let dueDateBase: String?
    public let estimatedMinutes: Int?
    public let harvestEnabled: Bool?
    public let hasDependencies: Int?
    public let hasPredecessors: Int?
    public let hasReminders: Bool?
    public let hasTickets: Bool?
    public let hasUnreadComments: Bool?
    public let id: Int?
    public let lastChangedOn: Date?
    public let lockdownID: String?
    public let order: Int?
    public let parentTaskID: String?
    public let position: Int?
    public let predecessors: [Predecessor]?
    public let priority: String?
    public let progress: Int?
    public let projectID: Int?
    public let projectName: String?
    public let responsiblePartyFirstname: String?
    public let responsiblePartyID: String?
    public let responsiblePartyIDS: String?
    public let responsiblePartyLastname: String?
    public let responsiblePartyNames: String?
    public let responsiblePartySummary: String?
    public let responsiblePartyType: String?
    public let startDate: String?
    public let status: String?
    public let tags: [Tag]?
    public let tasklistIsTemplate: Bool?
    public let tasklistLockdownID: String?
    public let tasklistPrivate: Bool?
    public let timeIsLogged: String?
    public let todoItemPrivate: Int?
    public let todoListID: Int?
    public let todoListName: String?
    public let userFollowingChanges: Bool?
    public let userFollowingComments: Bool?
    public let viewEstimatedTime: Bool?

    
    enum CodingKeys: String, CodingKey {
        case attachmentsCount = "attachments-count"
        case canComplete
        case canEdit
        case canLogTime
        case commentsCount = "comments-count"
        case companyID = "company-id"
        case companyName = "company-name"
        case completed
        case content
        case createdOn = "created-on"
        case creatorAvatarURL = "creator-avatar-url"
        case creatorFirstname = "creator-firstname"
        case creatorID = "creator-id"
        case creatorLastname = "creator-lastname"
        case description
        case dlm = "DLM"
        case dueDate = "due-date"
        case dueDateBase = "due-date-base"
        case estimatedMinutes = "estimated-minutes"
        case harvestEnabled = "harvest-enabled"
        case hasDependencies = "has-dependencies"
        case hasPredecessors = "has-predecessors"
        case hasReminders = "has-reminders"
        case hasTickets
        case hasUnreadComments = "has-unread-comments"
        case id
        case lastChangedOn = "last-changed-on"
        case lockdownID = "lockdownId"
        case order
        case parentTaskID = "parentTaskId"
        case position
        case predecessors
        case priority
        case progress
        case projectID = "project-id"
        case projectName = "project-name"
        case responsiblePartyFirstname = "responsible-party-firstname"
        case responsiblePartyID = "responsible-party-id"
        case responsiblePartyIDS = "responsible-party-ids"
        case responsiblePartyLastname = "responsible-party-lastname"
        case responsiblePartyNames = "responsible-party-names"
        case responsiblePartySummary = "responsible-party-summary"
        case responsiblePartyType = "responsible-party-type"
        case startDate = "start-date"
        case status
        case tags
        case tasklistIsTemplate = "tasklist-isTemplate"
        case tasklistLockdownID = "tasklist-lockdownId"
        case tasklistPrivate = "tasklist-private"
        case timeIsLogged
        case todoItemPrivate = "private"
        case todoListID = "todo-list-id"
        case todoListName = "todo-list-name"
        case userFollowingChanges = "userFollowingChanges"
        case userFollowingComments = "userFollowingComments"
        case viewEstimatedTime
    }
}
