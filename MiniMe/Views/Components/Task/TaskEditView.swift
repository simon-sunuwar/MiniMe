import SwiftUI

struct TaskEditView: View {
    @EnvironmentObject var taskViewModel: TaskViewModel
    var task: TaskModel
    @Binding var isEditing: Bool
    
    @State private var newTitle: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            TextField("Edit title", text: $newTitle)
                .onAppear {
                    newTitle = task.title
                }

            HStack {
                Button("Save") {
                    let updated = TaskModel(id: task.id, title: newTitle, isCompleted: task.isCompleted, parentId: task.parentId)
                    taskViewModel.editTask(updatedTask: updated)
                    isEditing = false
                }
                Button("Cancel") {
                    isEditing = false
                }
            }
            .font(.caption)
        }
        .padding(.top, 8)
    }
}

#Preview {
    let mockTask = TaskModel(id: UUID().uuidString, title: "Edit Me", isCompleted: false, parentId: "parent123")
    let viewModel = TaskViewModel()
    viewModel.tasks = [mockTask]

    // For previewing a binding
    @State var isEditing = true

    return TaskEditView(task: mockTask, isEditing: .constant(true))
        .environmentObject(viewModel)
        .previewLayout(.sizeThatFits)
        .padding()
}

