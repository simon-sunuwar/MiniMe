import SwiftUI

struct ToDoListScreen: View {
    @State private var selectedDate: Date = Date()

    var body: some View {
        VStack(spacing: 16) {
            // MARK: Date Picker
            DatePicker(
                "Select Date",
                selection: $selectedDate,
                displayedComponents: [.date]
            )
            .datePickerStyle(.compact)
            .padding(.horizontal)

            // MARK: Tasks for Selected Date
            TaskListView(
                filter: .custom { task in
                        guard let date = task.scheduledDate else { return false }
                        return Calendar.current.isDate(date, inSameDayAs: selectedDate) && !task.isCompleted
                    },
                allowsEditing: true
            )

            // MARK: Completed Tasks
            Text("Completed")
                .font(.headline)
                .padding(.top)

            TaskListView(
                filter: .completed(for: selectedDate),
                allowsEditing: false
            )
        }
    }
}

#Preview {
    ToDoListScreen()
        .environmentObject(TaskViewModel())
}



#Preview {
    ToDoListScreen()
        .environmentObject(TaskViewModel()) // Provide dummy model for testing
}

