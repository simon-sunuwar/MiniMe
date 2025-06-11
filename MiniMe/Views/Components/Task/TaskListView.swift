import SwiftUI

struct TaskListView: View {
    @Binding var tasks: [TaskModel]
    var showCompleted: Bool
    var selectedDate: Date
    @State private var focusedTaskID: UUID?
    @State private var newTaskTitle: String = ""

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 8) {
                // Filtered task rows
                ForEach($tasks.filter { $task in
                    if let date = $task.wrappedValue.scheduledDate {
                        return Calendar.current.isDate(date, inSameDayAs: selectedDate)
                            && (showCompleted ? $task.wrappedValue.isCompleted : !$task.wrappedValue.isCompleted)
                    }
                    return false
                }) { $task in
                    TaskRowView(task: $task, isFocused: focusedTaskID == $task.wrappedValue.id)
                }

                // Only show new task entry if NOT completed list
                if !showCompleted {
                    HStack {
                        Image(systemName: "plus.circle")
                            .foregroundColor(.blue)
                        TextField("New Task", text: $newTaskTitle, onCommit: {
                            let trimmed = newTaskTitle.trimmingCharacters(in: .whitespaces)
                            if !trimmed.isEmpty {
                                let newTask = TaskModel(title: trimmed, scheduledDate: selectedDate)
                                tasks.append(newTask)
                                newTaskTitle = ""
                            }
                        })
                        .textFieldStyle(.plain)
                    }
                    .padding(.vertical, 8)
                }
            }
            .padding(.horizontal)
        }
    }
}
