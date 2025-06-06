import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var taskViewModel: TaskViewModel
    
    var body: some View {
        VStack{
            if taskViewModel.activeTasks.isEmpty {
                Text("There are no active Tasks")
            } else {
                LazyVStack {
                    ForEach(taskViewModel.activeTasks) { task in
                        TaskRowView(task: task)
                    }
                    .onDelete(perform: taskViewModel.deleteTask)
                    .onMove(perform: taskViewModel.moveTask)
                }
            }
        }
    }
}


#Preview {
    TaskListView()
        .environmentObject(TaskViewModel())
}
