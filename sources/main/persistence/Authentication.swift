
import Foundation

final public class Authentication: NSObject
{
    let company: String
    let authorizationHeader: [String: String]
    
    init(company: String, apiKey: String){
        self.company = company
        let encodedApiKey = Data("\(apiKey):".utf8).base64EncodedString()
        self.authorizationHeader = ["Authorization": "BASIC \(encodedApiKey)"]
    }
    
    init(company: String, accessToken: String){
        self.company = company
        self.authorizationHeader = ["Authorization": "Bearer \(accessToken)"]
    }
    
    init(company: String, authorizationHeader: [String: String]){
        self.company = company
        self.authorizationHeader = authorizationHeader
    }
}
