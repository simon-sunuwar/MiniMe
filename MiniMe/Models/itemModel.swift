//
//  itemModel.swift
//  MiniMe
//
//  Created by Simon on 2025-05-08.
//

import Foundation

// Immutable Struct
// codable transform into data
struct ItemModel: Identifiable, Codable {
    let id: String
    let title: String
    let isCompleted: Bool
    
    // 2 different ItemModel, one with ID and one creates with new task
    init(id: String = UUID().uuidString , title: String, isCompleted: Bool) {
        self.id = UUID().uuidString
        self.title = title
        self.isCompleted = isCompleted
    }
    
    // let and not var, so the id, title, iscompleted is only updated with this func to avoid miss match titles.
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isCompleted: !isCompleted)
    }
}
