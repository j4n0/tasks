
import Foundation
@testable import Tasks

struct RandomValues
{
    static var date_YYYYMMDD: YYYYMMDDDate {
        return YYYYMMDDDate(date: Date())
    }
    
    static var dateTime_YYYYMMDDHHmmss: YYYYMMDDHHmmssDate {
        return YYYYMMDDHHmmssDate(date: Date())
    }
    
    static var randomString: String {
        return "DEADBEEF".shuffled().map { String($0) }.joined()
    }
    
    static var randomBool: Bool {
        return Bool.random()
    }
    
    static var randomUInt: UInt {
        return UInt.random(in: 0 ... 10)
    }
}

