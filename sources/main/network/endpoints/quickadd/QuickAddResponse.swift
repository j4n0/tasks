
import Foundation

public struct QuickAddResponse: Codable {
    
    public let tasklistId: String?
    public let success: String?
    public let taskIds: String?
    public let status: String?
    public let failed: String?
    
    enum CodingKeys: String, CodingKey {
        case tasklistId
        case success
        case taskIds
        case status = "STATUS"
        case failed
    }
}
