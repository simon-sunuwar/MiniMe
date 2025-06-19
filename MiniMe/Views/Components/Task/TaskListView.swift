import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var viewModel: TaskViewModel
    var filter: TaskFilter
    var isTitleEditable: Bool = true
    var isTaskEdit: Bool = false

    @State private var newTaskTitle: String = ""
    @FocusState private var isNewTaskFocused: Bool
    @State private var selectedDate = Date()

    var body: some View {
        List {
            ForEach(viewModel.filteredTasks(using: filter)) { task in
                TaskRowView(
                    task: task,
                    isTitleEditable: isTitleEditable,
                    isTaskEdit: isTaskEdit,
                    onUpdate: viewModel.updateTask,
                    onToggleComplete: viewModel.toggleTaskCompletion,
                    onDelete: { task in viewModel.deleteTask(task) }
                )
                .listRowSeparator(.hidden) // Optional: remove default line
                .listRowInsets(.init(top: 4, leading: 0, bottom: 4, trailing: 0)) // Optional: control spacing
            }

            if isTitleEditable {
                HStack {
                    TextField("New Task...", text: $newTaskTitle)
                        .focused($isNewTaskFocused)
                        .onSubmit {
                            let trimmed = newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines)
                            guard !trimmed.isEmpty else { return }
                            viewModel.addTask(title: trimmed, date: selectedDate)
                            newTaskTitle = "" // clear field
                            isNewTaskFocused = true // optionally refocus
                        }
                        .textFieldStyle(.plain)
                        .submitLabel(.done)
                }
                .padding(.vertical, 8)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)) // 👈 This removes side padding
            }
        }
        .listStyle(.plain) // Makes it look closer to LazyVStack
    }
}

#Preview {
    ToDoListScreen()
        .environmentObject(TaskViewModel()) // Provide dummy model for testing
}

