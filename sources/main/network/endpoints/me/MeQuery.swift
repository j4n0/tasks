
import Foundation

/// Query for GET /me.json - Get Current User Details
/// https://developer.teamwork.com/projects/people/get-current-user-details
struct MeQuery: QueryDictionaryConvertible {
    var getPreferences: Bool
    var fullProfile: Bool
    var getDefaultFilters: Bool
    var sharedFilter: Bool
    var getAccounts: Bool
    var includeAuth: Bool
}
