import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [TaskModel] = [] {
        didSet {
            saveTasks()
        }
    }

    private let tasksKey = "tasks"

    init() {
        getTasks()
    }

    // MARK: - Load from Storage
    func getTasks() {
        guard let data = UserDefaults.standard.data(forKey: tasksKey),
              let savedItems = try? JSONDecoder().decode([TaskModel].self, from: data) else {
            return
        }
        self.tasks = savedItems
    }

    // MARK: - Save to Storage
    private func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: tasksKey)
        }
    }

    // MARK: - Create
    func addTask(title: String) {
        let newTask = TaskModel(title: title)
        tasks.append(newTask)
    }

    // MARK: - Delete
    func deleteTask(at indexSet: IndexSet) {
        tasks.remove(atOffsets: indexSet)
    }

    // MARK: - Toggle Completion
    func toggleComplete(task: TaskModel) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task.copy(isCompleted: !task.isCompleted)
        }
    }

    // MARK: - Edit Task
    func updateTask(_ updatedTask: TaskModel) {
        if let index = tasks.firstIndex(where: { $0.id == updatedTask.id }) {
            tasks[index] = updatedTask
        }
    }

    // MARK: - Reorder Tasks
    func moveTask(fromOffsets: IndexSet, toOffset: Int) {
        tasks.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }

    // MARK: - Filtered Lists
    var activeTasks: [TaskModel] {
        tasks.filter { !$0.isCompleted }
    }

    var completedTasks: [TaskModel] {
        tasks.filter { $0.isCompleted }
    }

    func tasks(for date: Date) -> [TaskModel] {
        tasks.filter {
            guard let taskDate = $0.scheduledDate else { return false }
            return Calendar.current.isDate(taskDate, inSameDayAs: date)
        }
    }
}
