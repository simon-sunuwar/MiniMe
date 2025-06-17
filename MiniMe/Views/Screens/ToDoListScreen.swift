import SwiftUI

struct ToDoListScreen: View {
    private let daysRange = (-10...10)
    @State private var currentIndex = 10 // Today is at index 10
    @State private var datePickerSelection = Date()

    var body: some View {
        VStack {
            // Tappable "Today" label
            HStack {
                Button(action: {
                    withAnimation {
                        currentIndex = abs(daysRange.lowerBound) // Jump to today's page
                    }
                }) {
                    Text(currentIndex == abs(daysRange.lowerBound) ? "Today's Tasks" : "Go to Today")
                        .font(.headline)
                        .foregroundColor(.blue) // Optional: make it look like a tappable button
                }
                
                Spacer()
                
                DatePicker("", selection: $datePickerSelection, displayedComponents: [.date])
                    .onChange(of: datePickerSelection) { newDate in
                        let today = Calendar.current.startOfDay(for: Date())
                        let selectedDay = Calendar.current.startOfDay(for: newDate)

                        if let offset = Calendar.current.dateComponents([.day], from: today, to: selectedDay).day,
                           daysRange.contains(offset) {
                            withAnimation {
                                currentIndex = offset - daysRange.lowerBound
                            }
                        }
                    }

            }
            .padding(.horizontal)

            // Swipeable Task Pages
            TabView(selection: $currentIndex) {
                ForEach(Array(daysRange.enumerated()), id: \.offset) { offset, dayOffset in
                    let date = Calendar.current.date(byAdding: .day, value: dayOffset, to: Date()) ?? Date()

                    VStack(spacing: 12) {
                        TaskListView(
                            filter: .custom { task in
                                guard let scheduled = task.scheduledDate else { return false }
                                return Calendar.current.isDate(scheduled, inSameDayAs: date) && !task.isCompleted
                            },
                            allowsEditing: true
                        )

                        Text("Completed")
                            .font(.headline)
                            .padding(.top)

                        TaskListView(
                            filter: .completed(for: date),
                            allowsEditing: false
                        )
                    }
                    .padding()
                    .tag(offset)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onChange(of: currentIndex) { newIndex in
                datePickerSelection = selectedDate
            }
        }
    }

    var selectedDate: Date {
        Calendar.current.date(byAdding: .day, value: daysRange.lowerBound + currentIndex, to: Date()) ?? Date()
    }
}
