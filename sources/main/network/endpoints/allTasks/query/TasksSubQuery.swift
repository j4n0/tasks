
import Foundation

struct TasksSubQuery
{
    var completedAfterDate: YYYYMMDDHHmmssDate?
    var completedBeforeDate: YYYYMMDDHHmmssDate?
    var creatorIds: String?
    var endDate: YYYYMMDDDate?
    var filter: String?
    var getFiles: Bool?
    var getSubTasks: String?
    var ignoreStartDates: Bool?
    var include: String?
    var includeCompletedSubtasks: Bool?
    var includeCompletedTasks: Bool?
    var includeToday: Bool?
    var nestSubTasks: String?
    var page: UInt?
    var pageSize: UInt?
    var responsiblePartyIds: String?
    var showDeleted: String?
    var sort: String?
    var startDate: YYYYMMDDDate?
    var tagIds: String?
    var updatedAfterDate: YYYYMMDDHHmmssDate?
}

extension TasksSubQuery: QueryDictionaryConvertible {
    var renamePropertyKeys: [String: String]? {
        get {
            return [
                "creatorIds": "creator-ids",
                "responsiblePartyIds": "responsible-party-ids",
                "ignoreStartDates": "ignore-start-dates",
                "tagIds": "tag-ids"
            ]
        }
    }
}
