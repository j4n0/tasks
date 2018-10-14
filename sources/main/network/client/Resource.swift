
import Foundation

struct Resource
{    
    enum HTTPMethod: String {
        case delete = "DELETE", get = "GET", post = "POST", put = "PUT"
    }
    
    let path: String
    let method: HTTPMethod
    let query: [String: String?]
    let httpBody: Data?

    init(path: String, method: HTTPMethod = .get, query: [String: String?] = [:], httpBody: Data? = nil) {
        self.path = path
        self.method = method
        self.query = query
        self.httpBody = httpBody
    }
}
