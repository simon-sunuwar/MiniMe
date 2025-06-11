import Foundation

struct TaskModel: Identifiable, Codable, Equatable {
    let id: UUID
    let title: String
    let isCompleted: Bool
    let scheduledDate: Date?
    let dueDate: Date?
    let priority: TaskPriority
    let recurrence: RecurrenceRule?
    let timerMode: TimerMode?
    
    let parentID: UUID?   // Used if this is a subtask
    let isSubtask: Bool   // View-level logic, not strictly required
    
    init(
        id: UUID = UUID(),
        title: String,
        isCompleted: Bool = false,
        scheduledDate: Date? = nil,
        dueDate: Date? = nil,
        priority: TaskPriority = .normal,
        recurrence: RecurrenceRule? = nil,
        timerMode: TimerMode? = nil,
        parentID: UUID? = nil,
        isSubtask: Bool = false
    ) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.scheduledDate = scheduledDate
        self.dueDate = dueDate
        self.priority = priority
        self.recurrence = recurrence
        self.timerMode = timerMode
        self.parentID = parentID
        self.isSubtask = isSubtask
    }

    // MARK: - Copy Function for Immutability
    func copy(
        id: UUID? = nil,
        title: String? = nil,
        isCompleted: Bool? = nil,
        scheduledDate: Date?? = nil,
        dueDate: Date?? = nil,
        priority: TaskPriority? = nil,
        recurrence: RecurrenceRule?? = nil,
        timerMode: TimerMode?? = nil,
        parentID: UUID?? = nil,
        isSubtask: Bool? = nil
    ) -> TaskModel {
        return TaskModel(
            id: id ?? self.id,
            title: title ?? self.title,
            isCompleted: isCompleted ?? self.isCompleted,
            scheduledDate: scheduledDate ?? self.scheduledDate,
            dueDate: dueDate ?? self.dueDate,
            priority: priority ?? self.priority,
            recurrence: recurrence ?? self.recurrence,
            timerMode: timerMode ?? self.timerMode,
            parentID: parentID ?? self.parentID,
            isSubtask: isSubtask ?? self.isSubtask
        )
    }
}

enum TaskPriority: String, Codable {
    case low, normal, high
}

enum RecurrenceRule: String, Codable {
    case none, daily, weekly, monthly
}

enum TimerMode: Equatable, Codable {
    case countdown(minutes: Int)
    case stopwatch
}
