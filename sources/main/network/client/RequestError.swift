
import Foundation

enum RequestError: Error
{
    case malformedAuthenticationCode(String)
    case noDataReturned
    case httpStatus(Int)
    case urlLoading(Error)
    case unexpected
    case parsing(Error)
    case invalidEndpointDefinition(Resource, URL)
    
    init?(httpStatus: Int) {
        switch httpStatus {
        case 400...599: self = RequestError.httpStatus(httpStatus)
        default: return nil
        }
    }
    
    var localizedDescription: String {
        switch self {
        case .malformedAuthenticationCode(let code):
            return String(format: NSLocalizedString("RequestError.malformedAuthenticationCode", comment: ""), code)
        case .noDataReturned:
            return NSLocalizedString("RequestError.noDataReturned", comment: "")
        case let .httpStatus(code):
            return String(format: NSLocalizedString("RequestError.httpStatus", comment: ""), code)
        case let .urlLoading(e):
            return String(format: NSLocalizedString("RequestError.urlLoading", comment: ""), e.localizedDescription)
        case .unexpected:
            return NSLocalizedString("RequestError.unexpected", comment: "")
        case let .parsing(error):
            // the underlying error is probably a DecodingError. Either parse with a switch or do a "\(error)" to dump everything
            return String(format: NSLocalizedString("RequestError.parsing", comment: ""), "\(error)")
        case let .invalidEndpointDefinition(res, url):
            return String(format: NSLocalizedString("RequestError.invalidEndpointDefinition", comment: ""), String(describing: res), String(describing: url))
        }
    }
}
