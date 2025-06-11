//import SwiftUI
//
//struct TaskEditView: View {
//    @Binding var task: TaskModel
//    @State private var editedTitle: String = ""
//    var onSave: (TaskModel) -> Void
//    var onCancel: () -> Void
//
//    var body: some View {
//        VStack(spacing: 4) {
//            Divider()
//            HStack {
//                TextField("Edit task...", text: $editedTitle)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .onAppear {
//                        editedTitle = task.title
//                    }
//                Button("Save") {
//                    var updated = task
//                    updated.title = editedTitle
//                    onSave(updated)
//                }
//                .buttonStyle(.borderedProminent)
//
//                Button("Cancel", action: onCancel)
//                    .buttonStyle(.bordered)
//            }
//            .padding()
//        }
//        .background(Color(.systemBackground))
//        .cornerRadius(12)
//        .shadow(radius: 5)
//        .padding()
//    }
//}
//
////struct TaskEditView_Previews: PreviewProvider {
////    @State static var task = TaskModel(id: "first", title: "First item!", isCompleted: true)
////
////    static var previews: some View {
////        TaskEditView(
////            task: $task, // Binding here
////            onSave: {_ in },
////            onCancel: {}
////        )
////        .padding()
////        .previewLayout(.sizeThatFits)
////    }
////}
