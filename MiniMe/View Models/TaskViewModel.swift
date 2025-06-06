// CRUD FUNCTIONS
import Foundation

class TaskViewModel: ObservableObject{
    @Published var tasks: [TaskModel] = []{
        didSet{
            saveTasks()
        }
    }
    
    init() { getTasks()}
    let tasksKey = "tasks"
    
    // MARK: Create / Delete Task
    func addTask(title: String) {
        let newTask = TaskModel(title: title, isCompleted: false)
        tasks.append(newTask)
    }
    
    func deleteTask(indexSet: IndexSet) {
        tasks.remove(atOffsets: indexSet)
    }
    
    
    // MARK: Task Status
    var activeTasks: [TaskModel] {
        tasks.filter{!$0.isCompleted}
    }
    
    var completedTasks: [TaskModel] {
        tasks.filter{$0.isCompleted}
    }
    
    func toggleCompleteTask(task: TaskModel) {
        if let index = tasks.firstIndex(where: { $0.id == task.id}) {
            tasks[index] = task.updateCompletion()
        }
    }
    
//    func cleanOldCompletedTasks(olderThan days: Int = 1) {
//        let cutoffDate = Calendar.current.date(byAdding: .day, value: -days, to: Date())!
//                tasks.removeAll { task in
//                    task.isCompleted && (task.completedDate ?? Date()) < cutoffDate
//                }
//    }
   
    // MARK: Read/Save Task
    func getTasks() {
        guard
            let data = UserDefaults.standard.data(forKey: tasksKey),
            let savedItems = try? JSONDecoder().decode([TaskModel].self, from: data)
        else { return }
        self.tasks = savedItems
    }
    
    
    func saveTasks() {
        if let encodedData = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encodedData, forKey: tasksKey)
        }
    }
    
    // MARK: Modify/Update Task
    func moveTask(from: IndexSet, to: Int) {
        tasks.move(fromOffsets: from, toOffset: to)
    }
   
    func editTask( updatedTask: TaskModel){
        if let index = tasks.firstIndex(where: { $0.id == updatedTask.id}) {
            tasks[index] = updatedTask
        }
    }
}

// MARK: Preview
class PreviewTaskViewModel: TaskViewModel {
    override init() {
        super.init()
        self.tasks = [
            TaskModel(title: "First item!", isCompleted: false, parentId: "123"),
            TaskModel(title: "Second item!", isCompleted: true, parentId: "123")
        ]
    }
}
