//
//  taskModel.swift
//  MiniMe
//
//  Created by Simon on 2025-05-08.
//

import Foundation

// Immutable Struct
// codable transform into data
struct TaskModel: Identifiable, Codable {
    let id: String
    let title: String
    let isCompleted: Bool
    let completedDate: Date?
    
    // 2 different ItemModel, one with ID and one creates with new task
    init(id: String = UUID().uuidString , title: String, isCompleted: Bool, completedDate: Date? = nil) {
        self.id = UUID().uuidString
        self.title = title
        self.isCompleted = isCompleted
        self.completedDate = completedDate
    }
    
    // let and not var, so the id, title, iscompleted is only updated with this func to avoid miss match titles.
    // have not called up this function yet still testing
    func updateCompletion() -> TaskModel {
        return TaskModel(id: id, title: title, isCompleted: !isCompleted, completedDate: isCompleted ? nil : Date())
    }
}
