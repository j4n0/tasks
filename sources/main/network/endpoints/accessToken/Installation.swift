
import Foundation

/// Part of LoginResponse
public struct Installation: Codable
{
    public let id: Int
    public let name: String
    public let region: String
    public let apiEndPoint: String
    public let url: String
    public let chatEnabled: Bool
    public let company: Company
    public let logo: String
}
