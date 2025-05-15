//  Created by Simon on 2025-05-01.

import Foundation

enum TaskCategory: String, CaseIterable, Identifiable {
    case fitness
    case study
    case meditation
    case creativity
    case other
    
    var id: String { self.rawValue }
}

struct Task: Identifiable {
    let id = UUID()
    var title: String
    var category: TaskCategory
    var duration: Int // in minutes
    var isCompleted: Bool = false
}

