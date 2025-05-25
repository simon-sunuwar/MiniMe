//
//  ListViewModel.swift
//  MiniMe
//
//  Created by Simon on 2025-05-08.
//

import Foundation

/*
 CRUD FUNCTIONS
 
 Create
 Read
 Update
 Delete
 
 */

class TaskViewModel: ObservableObject{
    
    // @Published render's data changes to view
    @Published var tasks: [TaskModel] = []{
    // Data changes triggers function
        didSet{
            saveTasks()
        }
    }
    
    var activeTasks: [TaskModel] {
        tasks.filter{!$0.isCompleted}
    }
    
    var completedTasks: [TaskModel] {
        tasks.filter{$0.isCompleted}
    }
    
    init() {
        getTasks()
    }
    
    let tasksKey = "tasks"
    
    func getTasks() {
        guard
            let data = UserDefaults.standard.data(forKey: tasksKey),
            let savedItems = try? JSONDecoder().decode([TaskModel].self, from: data)
        else { return }
        self.tasks = savedItems
    }
    
    func deleteTask(indexSet: IndexSet) {
        tasks.remove(atOffsets: indexSet)
    }
    
    func moveTask(from: IndexSet, to: Int) {
        tasks.move(fromOffsets: from, toOffset: to)
    }
    
    func addTask(title: String) {
        let newTask = TaskModel(title: title, isCompleted: false)
        tasks.append(newTask)
    }
    
    func toggleCompleteTask(task: TaskModel) {
        if let index = tasks.firstIndex(where: { $0.id == task.id}) {
            tasks[index] = task.updateCompletion()
        }
    }
    
    func saveTasks() {
        if let encodedData = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encodedData, forKey: tasksKey)
        }
    }
    
    func cleanOldCompletedTasks(olderThan days: Int = 1) {
        let cutoffDate = Calendar.current.date(byAdding: .day, value: -days, to: Date())!
                tasks.removeAll { task in
                    task.isCompleted && (task.completedDate ?? Date()) < cutoffDate
                }
    }
}
