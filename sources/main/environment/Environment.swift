
import Foundation

public protocol Environment: class
{
    var coordinator: Coordinator { get set }
    var store: StoreType { get set }
    var teamworkClient: TeamworkClient? { get set }
    var authenticatingClient: AuthenticatingClient { get set }
    
    func removeAuthentication()
}
