
import Foundation

class MockedTeamworkClient: TeamworkClient
{
    var mockedSession = MockURLSession()
    
    init(){
        let baseURL = URL(string: "http://unused")!
        super.init(session: mockedSession, baseURL: baseURL)
    }
    
    override func allTasks(completion: @escaping ApiResultCompletion<AllTasksResponse>) {
        mockedSession.nextData = data(forResource: "allTasks", ofType: "json")
        super.allTasks(completion: completion)
    }
    
    func data(forResource name: String, ofType type: String) -> Data? {
        guard let url = Bundle.main.url(forResource: name, withExtension: type) else { return nil }
        return try? Data(contentsOf: url)
    }
}
