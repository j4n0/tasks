
import Foundation

/// Response from https://www.teamwork.com/launchpad/v1/token.json
public struct AccessTokenResponse: Codable
{
    public let accessToken: String?
    public let installation: Installation?
    public let status: String?
    public let user: User?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case installation
        case status
        case user
    }
}
