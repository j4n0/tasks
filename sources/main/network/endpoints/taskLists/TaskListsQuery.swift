
import Foundation

// Query string for "Get all task lists across projects".
struct TaskListsQuery: QueryDictionaryConvertible
{
    var pagination: PaginationSubQuery?
}

struct PaginationSubQuery: QueryDictionaryConvertible {
    var status: String?
    var page: String?
    var pageSize: String?
}
