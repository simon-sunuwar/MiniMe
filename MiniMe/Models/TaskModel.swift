import Foundation

struct TaskModel: Identifiable, Codable, Hashable {
    let id: UUID
    let title: String
    let isCompleted: Bool
    let scheduledDate: Date?

    init(id: UUID = UUID(), title: String, isCompleted: Bool = false, scheduledDate: Date? = nil) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.scheduledDate = scheduledDate
    }

    func copy(
        title: String? = nil,
        isCompleted: Bool? = nil,
        scheduledDate: Date?? = nil
    ) -> TaskModel {
        TaskModel(
            id: self.id,
            title: title ?? self.title,
            isCompleted: isCompleted ?? self.isCompleted,
            scheduledDate: scheduledDate ?? self.scheduledDate
        )
    }
}
