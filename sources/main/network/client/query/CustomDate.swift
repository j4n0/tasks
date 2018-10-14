
import Foundation

/// Date formatter.
/// Used as type as part of some query items.
class CustomDate
{
    private let date: Date
    
    init(date: Date){
        self.date = date
    }
    
    private static let rfc3339 = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    
    var dateFormat: String { return CustomDate.rfc3339 }
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = dateFormat
        return formatter
    }()
    
    var stringValue: String {
        return dateFormatter.string(from: date)
    }
}

class YYYYMMDDDate: CustomDate {
    override var dateFormat: String { return "YYYYMMDD" }
}

class YYYYMMDDHHmmssDate: CustomDate {
    override var dateFormat: String { return "YYYYMMDDHHmmss" }
}
