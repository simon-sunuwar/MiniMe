import Foundation

enum TaskFilter {
    case all
    case completed(for: Date)
    case active
    case today
    case byDate(Date)
    case custom((TaskModel) -> Bool)
}
