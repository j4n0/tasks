
import Foundation

final class Plist
{
    let dictionary: [String: String]?
    
    init(forResource resource: String, ofType type: String, bundle: Bundle? = nil){
        dictionary = (bundle ?? Bundle.main).path(forResource: resource, ofType: type)
            .flatMap({ NSDictionary(contentsOfFile: $0) as? [String: String] })
    }
}
