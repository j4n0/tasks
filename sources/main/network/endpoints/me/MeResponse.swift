
import Foundation

/// Response to GET /me.json - Get Current User Details
/// https://developer.teamwork.com/projects/people/get-current-user-details
public struct MeResponse: Codable {
    public let person: Person?
    public let status: String?
    
    enum CodingKeys: String, CodingKey {
        case person
        case status = "STATUS"
    }
}

public struct Person: Codable {
    public let administrator: Bool?
    public let pid: String?
    public let siteOwner: Bool?
    public let twitter: String?
    public let phoneNumberHome: String?
    public let lastName: String?
    public let emailAddress: String?
    public let profile: String?
    public let userUuid: String?
    public let userName: String?
    public let id: String?
    public let companyName: String?
    public let lastChangedOn: Date?
    public let phoneNumberOffice: String?
    public let deleted: Bool?
    public let privateNotes: String?
    public let phoneNumberMobile: String?
    public let firstName: String?
    public let userType: String?
    public let permissions: Permissions?
    public let imService: String?
    public let address: Address?
    public let imHandle: String?
    public let createdAt: Date?
    public let phoneNumberOfficeExt: String?
    public let companyId: String?
    public let hasAccessToNewProjects: Bool?
    public let phoneNumberFax: String?
    public let avatarUrl: String?
    public let inOwnerCompany: String?
    public let lastLogin: Date?
    public let emailAlt1: String?
    public let emailAlt2: String?
    public let emailAlt3: String?
    public let personCompanyId: String?
    public let title: String?
    
    enum CodingKeys: String, CodingKey {
        case administrator
        case pid
        case siteOwner = "site-owner"
        case twitter
        case phoneNumberHome = "phone-number-home"
        case lastName = "last-name"
        case emailAddress = "email-address"
        case profile
        case userUuid = "userUUID"
        case userName = "user-name"
        case id
        case companyName = "company-name"
        case lastChangedOn = "last-changed-on"
        case phoneNumberOffice = "phone-number-office"
        case deleted
        case privateNotes = "privateNotes"
        case phoneNumberMobile = "phone-number-mobile"
        case firstName = "first-name"
        case userType = "user-type"
        case permissions
        case imService = "im-service"
        case address
        case imHandle = "im-handle"
        case createdAt = "created-at"
        case phoneNumberOfficeExt = "phone-number-office-ext"
        case companyId = "company-id"
        case hasAccessToNewProjects = "has-access-to-new-projects"
        case phoneNumberFax = "phone-number-fax"
        case avatarUrl = "avatar-url"
        case inOwnerCompany = "in-owner-company"
        case lastLogin = "last-login"
        case emailAlt1 = "email-alt-1"
        case emailAlt2 = "email-alt-2"
        case emailAlt3 = "email-alt-3"
        case personCompanyId = "companyId"
        case title
    }
}

public struct Address: Codable {
    public let zipcode: String?
    public let countrycode: String?
    public let state: String?
    public let line1: String?
    public let country: String?
    public let line2: String?
    public let city: String?
    
    enum CodingKeys: String, CodingKey {
        case zipcode
        case countrycode
        case state
        case line1
        case country
        case line2
        case city
    }
}

public struct Permissions: Codable {
    public let canManagePeople: Bool?
    public let canAddProjects: Bool?
    
    enum CodingKeys: String, CodingKey {
        case canManagePeople = "can-manage-people"
        case canAddProjects = "can-add-projects"
    }
}
