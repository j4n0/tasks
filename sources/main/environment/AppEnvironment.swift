
import Foundation
import os

final public class AppEnvironment: Environment
{
    public var coordinator = Coordinator(screen: .login)
    public var store: StoreType = Store<UserDefaultsKeyValueStore>()
    public var teamworkClient: TeamworkClient?
    public var authenticatingClient = AuthenticatingClient()
    public var style: StyleElement = StyleElement.decodeJsonFile(resource: "style", withExtension: "json")!
    
    convenience init(configuration: Configuration?){
        if let company = configuration?.company, let apiKey = configuration?.apiKey {
            self.init(authentication: Authentication(company: company, apiKey: apiKey))
        } else {
            os_log("The configuration doesn’t contain authentication credentials")
            self.init(authentication: nil)
        }
    }
    
    init(authentication: Authentication?){
        let auth = authentication ?? store.authentication
        if authentication == nil {
            os_log("No authentication passed.")
            if auth == nil {
                os_log("No authentication in the store either. Login required")
            } else {
                os_log("Found an authentication in the store.")
            }
        }
        self.coordinator = Coordinator(screen: auth == nil ? .login : .taskList)
        self.teamworkClient = TeamworkClient(authentication: auth)
        observeAccessToken()
    }
    
    public func removeAuthentication(){
        os_log(.debug, log: OSLog.default, "Removing authentication.")
        store.removeEverything()
        coordinator = Coordinator(screen: .login)
        teamworkClient = TeamworkClient(authentication: nil)
        observeAccessToken()
    }
    
    // MARK: - Observe authentication
    
    private var authenticationObservation: NSKeyValueObservation?
    
    // If the access code change to a non nil value, we’ll initialise the network client.
    private func observeAccessToken() {
        if let store = self.store as? Store<UserDefaultsKeyValueStore> {
            self.authenticationObservation = store.observe(\.authentication, options: [.new]) { (store, change) in
                if let _ = change.newValue {
                    self.teamworkClient = TeamworkClient(authentication: store.authentication)
                }
            }
        }
    }
}
