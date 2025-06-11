import SwiftUI

struct ToDoListScreen: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var selectedDate: Date = Date()

    var body: some View {
        VStack {
            Text("TO DO LIST MF")
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                .datePickerStyle(.compact)
                .padding()

            TaskListView(tasks: $viewModel.tasks, showCompleted: false, selectedDate: selectedDate)
            
            Text("Completed")
            
            TaskListView(tasks: $viewModel.tasks, showCompleted: true, selectedDate: selectedDate)
        }
    }
}

#Preview {
    ToDoListScreen()
        .environmentObject(TaskViewModel()) // Provide dummy model for testing
}

