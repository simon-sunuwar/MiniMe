import Foundation
import SwiftUI

class TaskViewModel: ObservableObject {
    @Published private(set) var tasks: [TaskModel] = [] {
        didSet {
            saveTasks()
        }
    }

    private let tasksKey = "tasks"

    init() {
        loadTasks()
    }

    // MARK: - Public API

    func addTask(title: String, date: Date? = nil) {
        let newTask = TaskModel(title: title, scheduledDate: date)
        tasks.append(newTask)
    }
    
    func updateTask(_ updatedTask: TaskModel) {
        if let index = tasks.firstIndex(where: { $0.id == updatedTask.id }) {
            tasks[index] = updatedTask
        }
    }

    func toggleTaskCompletion(_ task: TaskModel) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            let nowCompleted = !task.isCompleted
            let newCompletedDate = nowCompleted ? Date() : nil

            tasks[index] = task.copy(
                isCompleted: nowCompleted,
                completedDate: newCompletedDate
            )
        }
    }

    func deleteTask(_ task: TaskModel) {
        tasks.removeAll { $0.id == task.id }
    }

    func moveTask(fromOffsets: IndexSet, toOffset: Int) {
        tasks.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    func activeTasks(for date: Date) -> [TaskModel] {
        tasks.filter { !$0.isCompleted && Calendar.current.isDate($0.scheduledDate ?? Date.distantPast, inSameDayAs: date) }
    }

    func completedTasks(for date: Date) -> [TaskModel] {
        tasks.filter { $0.isCompleted && Calendar.current.isDate($0.scheduledDate ?? Date.distantPast, inSameDayAs: date) }
    }


    // MARK: - Filters

    func filteredTasks(using filter: TaskFilter) -> [TaskModel] {
        switch filter {
        case .all:
            return tasks
        case .completed(let date):
            return tasks.filter {
                $0.isCompleted &&
                $0.completedDate != nil &&
                Calendar.current.isDate($0.completedDate!, inSameDayAs: date)
            }
        case .active:
            return tasks.filter { !$0.isCompleted }
        case .today:
            return tasks.filter {
                guard let date = $0.scheduledDate else { return false }
                return Calendar.current.isDateInToday(date)
            }
        case .byDate(let date):
            return tasks.filter {
                guard let taskDate = $0.scheduledDate else { return false }
                return Calendar.current.isDate(taskDate, inSameDayAs: date)
            }
        case .custom(let predicate):
            return tasks.filter(predicate)
        }
    }

    // MARK: - Persistence

    private func saveTasks() {
        if let data = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(data, forKey: tasksKey)
        }
    }

    private func loadTasks() {
        guard let data = UserDefaults.standard.data(forKey: tasksKey),
              let decoded = try? JSONDecoder().decode([TaskModel].self, from: data) else {
            return
        }
        self.tasks = decoded
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
