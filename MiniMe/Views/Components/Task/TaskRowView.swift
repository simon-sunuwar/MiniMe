import SwiftUI

struct TaskRowView: View {
    @Binding var task: TaskModel
    var isFocused: Bool
    var onCommit: () -> Void = {}

    var body: some View {
        HStack {
            Button(action: {
                task = task.copy(isCompleted: !task.isCompleted)
            }) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
            }

            TextField("New Task", text: Binding(
                get: { task.title },
                set: { task = task.copy(title: $0) }
            ), onCommit: onCommit)
            .textFieldStyle(.plain)
            .focused($focused, equals: true)
        }
        .padding(.vertical, 4)
    }

    @FocusState private var focused: Bool
}


//
//#Preview {
//    Group {
//        TaskRowView(task: .constant(TaskModel(
//            id: UUID(),
//            title: "Sample Task",
//            isCompleted: false,
//            scheduledDate: Date()
//        )))
//        
//        TaskRowView(task: .constant(TaskModel(
//            id: UUID(),
//            title: "Completed Task",
//            isCompleted: true,
//            scheduledDate: Date()
//        )))
//    }
//    .previewLayout(.sizeThatFits)
//    .padding()
//}


//struct TaskRowView_Previews: PreviewProvider {
//    static let task1 = TaskModel(id: "first", title: "First item!", isCompleted: false)
//    static let task2 = TaskModel(id: "second", title: "Second item!", isCompleted: true)
//
//    static var previews: some View {
//        Group {
//            TaskRowView(task: .constant(task1))
//            TaskRowView(task: .constant(task2))
//        }
//        .previewLayout(.sizeThatFits)
//    }
//}


//struct TaskRowView: View {
//    @Binding var task: TaskModel
//    @State private var isEditing = false
//    @State private var editedText: String = ""
//    @FocusState private var isTextFieldFocused: Bool // 👈 Focus state for keyboard
//
//    var body: some View {
//        HStack(){
//            if isEditing {
//                            TextField("Enter task...", text: $editedText, onCommit: {
//                                task.title = editedText
//                                isEditing = false
//                            })
//                            .focused($isTextFieldFocused) // 👈 Tells SwiftUI to focus this
//                            .onAppear {
//                                editedText = task.title
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                                    isTextFieldFocused = true // 👈 Triggers keyboard
//                                }
//                            }
//            } else {
//                Text(task.title.isEmpty ? "New Task" : task.title)
//                    .onTapGesture {
//                        isEditing = true
//                    }
//                Spacer()
//                Button(action: {
//                    withAnimation {
//                        task.isCompleted.toggle()
//                    }
//                }) {
//                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
//                        .foregroundColor(task.isCompleted ? .green : .gray)
//                        .imageScale(.large)
//                }
//            }
//        }
//        .padding(.vertical, 6)
//    }
//}
