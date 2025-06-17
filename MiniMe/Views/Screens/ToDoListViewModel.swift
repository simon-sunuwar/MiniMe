
import SwiftUI

class ToDoListViewModel: ObservableObject {
    @Published var selectedDate: Date = Date()
    @Published var swipeDirection: SwipeDirection = .none

    enum SwipeDirection {
        case left, right, none
    }

    func swipeLeft() {
        swipeDirection = .left
        selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate) ?? selectedDate
    }

    func swipeRight() {
        swipeDirection = .right
        selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate) ?? selectedDate
    }
}
