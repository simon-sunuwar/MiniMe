import SwiftUI

struct TaskRowView: View {
    let task: TaskModel
    var isEditable: Bool = true
    var onUpdate: (TaskModel) -> Void
    var onToggleComplete: (TaskModel) -> Void
    

    @State private var title: String
    @FocusState private var isFocused: Bool

    init(
        task: TaskModel,
        isEditable: Bool = true,
        onUpdate: @escaping (TaskModel) -> Void,
        onToggleComplete: @escaping (TaskModel) -> Void
    ) {
        self.task = task
        self.isEditable = isEditable
        self.onUpdate = onUpdate
        self.onToggleComplete = onToggleComplete
        _title = State(initialValue: task.title)
    }

    var body: some View {
        HStack {
            if isEditable {
                TextField("", text: $title, onCommit: {
                    let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    if trimmed.isEmpty {
                        // Revert visually and functionally
                        DispatchQueue.main.async {
                            title = task.title
                        }
                    } else if trimmed != task.title {
                        onUpdate(task.copy(title: trimmed))
                    }
                })
                .textFieldStyle(.plain)
            } else {
                Text(task.title)
                    .foregroundColor(task.isCompleted ? .gray : .primary)
            }
            Spacer()
            Button(action: {
                onToggleComplete(task)
            }) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.isCompleted ? .green : .gray)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    TaskRowView(
        task: TaskModel(id: UUID(), title: "Sample Task", isCompleted: true),
        isEditable: true,
        onUpdate: { _ in },
        onToggleComplete: { _ in }
    )
}

