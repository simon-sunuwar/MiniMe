import Foundation

struct TaskModel: Identifiable, Codable, Hashable {
    let id: UUID
    let title: String
    let isCompleted: Bool
    let completedDate: Date?
    let scheduledDate: Date?
    
    init(id: UUID = UUID(), title: String, isCompleted: Bool = false, scheduledDate: Date? = nil, completedDate: Date? = nil) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.scheduledDate = scheduledDate
        self.completedDate = completedDate
    }

    func copy(
        title: String? = nil,
        isCompleted: Bool? = nil,
        scheduledDate: Date?? = nil,
        completedDate: Date?? = nil
    ) -> TaskModel {
        TaskModel(
            id: self.id,
            title: title ?? self.title,
            isCompleted: isCompleted ?? self.isCompleted,
            scheduledDate: scheduledDate ?? self.scheduledDate,
            completedDate: completedDate ?? self.completedDate
        )
    }
}
