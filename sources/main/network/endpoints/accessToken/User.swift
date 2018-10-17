
import Foundation

/// Part of AccessTokenResponse
public struct User: Codable
{
    public let id: Int?
    public let firstName: String?
    public let lastName: String?
    public let email: String?
    public let avatar: String?
    public let company: Company?
}

