
import Foundation

public class ApiClient {

    let session: URLSessionProtocol
    let baseURL: URL
    
    init(session: URLSessionProtocol, baseURL: URL) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func fetch<T: Decodable>(resource: Resource, completion: @escaping ApiResultCompletion<T>){
        // ...
    }
}
