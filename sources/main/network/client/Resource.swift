
import Foundation

struct Resource: ExpressibleByStringLiteral
{    
    enum HTTPMethod: String {
        case delete = "DELETE", get = "GET", post = "POST", put = "PUT"
    }
    
    let path: String
    let method: HTTPMethod
    let query: [String: String]
    let httpBody: Data?

    init(path: String, method: HTTPMethod = .get, query: [String: String] = [:], httpBody: Data? = nil) {
        self.path = path
        self.method = method
        self.query = query
        self.httpBody = httpBody
    }
    
    // MARK: - ExpressibleByStringLiteral
    
    typealias StringLiteralType = String
    
    init(stringLiteral value: StringLiteralType){
        self.init(path: value)
    }
}
