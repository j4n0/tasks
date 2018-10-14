import Foundation

public struct ProjectsResponse: Codable {
    public let status: String?
    public let projects: [Project]?
    
    enum CodingKeys: String, CodingKey {
        case status = "STATUS"
        case projects = "projects"
    }
}

public struct Project: Codable {
    public let company: ProjectCompany?
    public let starred: Bool?
    public let name: String?
    public let showAnnouncement: Bool?
    public let announcement: String?
    public let description: String?
    public let status: String?
    public let isProjectAdmin: Bool?
    public let createdOn: Date?
    public let category: Category?
    public let startPage: String?
    public let startDate: String?
    public let logo: String?
    public let notifyeveryone: Bool?
    public let id: String?
    public let lastChangedOn: Date?
    public let endDate: String?
    public let harvestTimersEnabled: Bool? //⚠️ documentation says string but it is a Bool
    
    enum CodingKeys: String, CodingKey {
        case company
        case starred
        case name
        case showAnnouncement = "show-announcement"
        case announcement
        case description
        case status
        case isProjectAdmin
        case createdOn = "created-on"
        case category
        case startPage = "start-page"
        case startDate
        case logo
        case notifyeveryone
        case id
        case lastChangedOn = "last-changed-on"
        case endDate
        case harvestTimersEnabled = "harvest-timers-enabled"
    }
}

public struct Category: Codable {
    public let name: String?
    public let id: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
    }
}

public struct ProjectCompany: Codable {
    public let name: String?
    public let isOwner: String?
    public let id: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case isOwner = "is-owner"
        case id
    }
}
