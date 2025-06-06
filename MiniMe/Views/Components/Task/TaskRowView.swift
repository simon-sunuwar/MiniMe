import SwiftUI

struct TaskRowView: View {
    @EnvironmentObject var taskViewModel: TaskViewModel
    let task: TaskModel

    @State private var isEditing = false
    @State private var editedTitle: String = ""

    var body: some View {
        VStack {
            HStack {
                if isEditing {
                    TextField("Edit task", text: $editedTitle)
                        .font(.title2)
                        .onAppear {
                            editedTitle = task.title
                        }

                    HStack {
                        Button("Save") {
                            let updated = TaskModel(
                                id: task.id,
                                title: editedTitle,
                                isCompleted: task.isCompleted,
                                parentId: task.parentId
                            )
                            taskViewModel.editTask(updatedTask: updated)
                            isEditing = false
                        }
                        .buttonStyle(.borderedProminent)

                        Button("Cancel") {
                            isEditing = false
                        }
                        .buttonStyle(.bordered)
                    }
                } else {
                    Text(task.title)
                        .font(.title3)
                        .onTapGesture {
                            isEditing = true
                        }

                    Spacer()

                    Button(action: {
                        withAnimation {
                            taskViewModel.toggleCompleteTask(task: task)
                        }
                    }) {
                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(task.isCompleted ? .green : .gray)
                            .imageScale(.large)
                    }
                }
            }

            if isEditing {
                HStack {
                    Button("Priority") { }
                    Button("Due Date") { }
                    Button("Tags") { }
                    Spacer()
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
        .background(isEditing ? Color.yellow : Color.clear)
        .cornerRadius(8)
        .offset(y: isEditing ? -100 : 0) // 👈 Float it upward
        .zIndex(isEditing ? 1 : 0)       // 👈 Bring to front if editing
        .animation(.easeInOut, value: isEditing)
    }
}

#Preview {
    let mockTask = TaskModel(id: UUID().uuidString, title: "Editable Task", isCompleted: false, parentId: "parent1")
    let mockVM = TaskViewModel()
    mockVM.tasks = [mockTask]

    return TaskRowView(task: mockTask)
        .environmentObject(mockVM)
        .previewLayout(.sizeThatFits)
        .padding()
}
