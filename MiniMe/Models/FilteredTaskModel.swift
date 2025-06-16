
import Foundation

struct FilteredTaskModel: Identifiable, Equatable {
    let task: TaskModel
    var isFocused: Bool = false
    var isDraft: Bool = false

    var id: UUID { task.id }

    func updatingTask(_ newTask: TaskModel) -> FilteredTaskModel {
        FilteredTaskModel(task: newTask, isFocused: isFocused, isDraft: isDraft)
    }

    func withFocus(_ focused: Bool) -> FilteredTaskModel {
        FilteredTaskModel(task: task, isFocused: focused, isDraft: isDraft)
    }

    func withDraft(_ draft: Bool) -> FilteredTaskModel {
        FilteredTaskModel(task: task, isFocused: isFocused, isDraft: draft)
    }
}
