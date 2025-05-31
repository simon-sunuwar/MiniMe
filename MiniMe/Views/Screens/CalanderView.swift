import SwiftUI

struct CalendarView: View {
    @State private var displayedMonth: Date = Date()
    
    
    
    private var calendar: Calendar {
        var cal = Calendar.current
        cal.firstWeekday = 1 // Sunday = 1, Monday = 2
        return cal
    }

    private var daysInMonth: [Date] {
        guard let range = calendar.range(of: .day, in: .month, for: displayedMonth),
              let monthStart = calendar.date(from: calendar.dateComponents([.year, .month], from: displayedMonth)) else {
            return []
        }

        let firstWeekday = calendar.component(.weekday, from: monthStart)
        let offset = firstWeekday - calendar.firstWeekday

        var days: [Date] = []

        // Fill start of month with empty placeholders
        for i in 0..<(offset < 0 ? offset + 7 : offset) {
            days.append(calendar.date(byAdding: .day, value: -1 - i, to: monthStart)!)
        }

        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: monthStart) {
                days.append(date)
            }
        }

        return days
    }

    private func isToday(_ date: Date) -> Bool {
        calendar.isDateInToday(date)
    }

    private func isCurrentMonth(_ date: Date) -> Bool {
        calendar.isDate(date, equalTo: displayedMonth, toGranularity: .month)
    }

    var body: some View {
        VStack {
            // Month navigation
            HStack {
                Button(action: {
                    displayedMonth = calendar.date(byAdding: .month, value: -1, to: displayedMonth)!
                }) {
                    Image(systemName: "chevron.left")
                }

                Spacer()

                Text(monthYearString(from: displayedMonth))
                    .font(.title2)
                    .bold()

                Spacer()

                Button(action: {
                    displayedMonth = calendar.date(byAdding: .month, value: 1, to: displayedMonth)!
                }) {
                    Image(systemName: "chevron.right")
                }
            }
            .padding(.horizontal)

            // Weekday headers
            let weekdaySymbols = calendar.shortStandaloneWeekdaySymbols
            HStack {
                ForEach(weekdaySymbols, id: \.self) { symbol in
                    Text(symbol)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity)
                }
            }

            // Grid of days
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                ForEach(daysInMonth, id: \.self) { date in
                    Text("\(calendar.component(.day, from: date))")
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(isToday(date) ? Color.blue.opacity(0.2) : Color.clear)
                        .foregroundColor(isCurrentMonth(date) ? .primary : .gray)
                        .clipShape(Circle())
                        .onTapGesture {
                            print("Tapped date: \(date)")
                        }
                }
            }

            Spacer()
        }
        .padding()
    }

    private func monthYearString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
}

#Preview {
    CalendarView()
}
