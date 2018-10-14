
import Foundation

/// Query for "Retrieve All Projects"
/// https://developer.teamwork.com/projects/projects/retrieve-all-projects
struct ProjectsQuery: QueryDictionaryConvertible
{
    var status: String?
    var updatedAfterDate: String?
    var orderby: String?
    var createdAfterDate: String?
    var createdAfterTime: String?
    var catId: Int?
    var includePeople: Bool?
    var includeProjectOwner: Bool?
}
