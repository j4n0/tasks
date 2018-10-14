
import Foundation

// Query string for "Get all tasks across all projects".
struct GetAllTasksQuery: QueryDictionaryConvertible
{
    var allTasksQuery = TasksSubQuery()
}
