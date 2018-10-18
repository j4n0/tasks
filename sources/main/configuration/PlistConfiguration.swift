
import os
import Foundation

final class PlistConfiguration: Configuration
{
    enum Keys: String {
        case company = "Company"
        case apiKey = "API Key"
    }
    
    var company: String?
    var apiKey: String?
    
    init?(forResource resource: String, ofType type: String, bundle: Bundle? = nil) {
        guard let dictionary = Plist(forResource: resource, ofType: type, bundle: bundle).dictionary else {
            os_log("Didn’t find %@.%@ in the bundle %@", resource, type, "\(bundle as Any)")
            return nil
        }
        self.company = dictionary[Keys.company.rawValue]
        self.apiKey = dictionary[Keys.apiKey.rawValue]
    }
}
