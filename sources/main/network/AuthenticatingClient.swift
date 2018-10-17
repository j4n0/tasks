
import Foundation

public class AuthenticatingClient: ApiClient
{
    convenience init() {
        let session = type(of: self).createSession()
        let baseURL = URL(string: "https://www.teamwork.com")!
        self.init(session: session, baseURL: baseURL)
    }
    
    override init(session: URLSessionProtocol, baseURL: URL) {
        super.init(session: session, baseURL: baseURL)
    }
    
    private static func createSession() -> URLSession {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        return URLSession(configuration: config)
    }
    
    func accessToken(authenticationCode: String, completion: @escaping ApiResultCompletion<AccessTokenResponse>)
    {
        guard let data = accessTokenPostBody(authenticationCode: authenticationCode) else {
            completion(.error(RequestError.malformedAuthenticationCode(authenticationCode)))
            return
        }
        let resource = Resource(path: "/launchpad/v1/token.json", method: .post, httpBody: data)
        fetch(resource: resource) { (result: ApiResult<AccessTokenResponse>) in
            switch result {
            case .success(_):
                completion(result)
            case .error(let e):
                completion(.error(e))
            }
        }
    }
    
    private func accessTokenPostBody(authenticationCode: String) -> Data? {
        var json = [String:Any]()
        json["code"] = authenticationCode
        return try? JSONSerialization.data(withJSONObject: json, options: [])
    }
}
