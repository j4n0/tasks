
import Foundation

class MockedAuthenticatingClient: AuthenticatingClient
{
    // stubbed JSON for the AccessTokenResponse
    let tokenJson: Data? = {
        guard let url = Bundle.main.url(forResource: "token", withExtension: "json") else { return nil }
        return try? Data(contentsOf: url)
    }()
    
    init(){
        let session = MockURLSession()
        session.nextData = tokenJson
        let baseURL = URL(string: "http://unused")!
        super.init(session: session, baseURL: baseURL)
    }
}
