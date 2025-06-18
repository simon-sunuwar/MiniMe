import SwiftUI

struct TaskRowView: View {
    let task: TaskModel
    var isTitleEditable: Bool = true
    var isTaskEdit: Bool = false
    var onUpdate: (TaskModel) -> Void
    var onToggleComplete: (TaskModel) -> Void
    

    @State private var title: String
    @FocusState private var isFocused: Bool

    init(
        task: TaskModel,
        isTitleEditable: Bool = true,
        isTaskEdit: Bool = false,
        onUpdate: @escaping (TaskModel) -> Void,
        onToggleComplete: @escaping (TaskModel) -> Void
    ) {
        self.task = task
        self.isTitleEditable = isTitleEditable
        self.isTaskEdit = isTaskEdit
        self.onUpdate = onUpdate
        self.onToggleComplete = onToggleComplete
        _title = State(initialValue: task.title)
    }

    var body: some View {
        HStack {
            if isTitleEditable {
                TextField("", text: $title, onCommit: {
                    let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
                    if trimmed.isEmpty {
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

            // 👇 This appears only in edit mode
            if isTaskEdit {
                Image(systemName: "pencil")
                    .foregroundColor(.gray)
                    .padding(.leading, 8)
                Image(systemName: "line.horizontal.3")
                    .foregroundColor(.gray)
                    .padding(.leading, 8)
                Image(systemName: "trash")
                    .foregroundColor(.gray)
                    .padding(.leading, 8)
            }

            Spacer()
            // ✅ Only show this button when not in edit mode
               if !isTaskEdit {
                   Button(action: {
                       onToggleComplete(task)
                   }) {
                       Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                           .foregroundColor(task.isCompleted ? .green : .gray)
                   }
               }
        }
    }
}

#Preview {
    TaskRowView(
        task: TaskModel(id: UUID(), title: "Sample Task", isCompleted: false),
        isTitleEditable: true,
        isTaskEdit: true,
        onUpdate: { _ in },
        onToggleComplete: { _ in }
    )
}

