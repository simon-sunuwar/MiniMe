//
//  ListRowView.swift
//  MiniMe
//
//  Created by Simon on 2025-05-07.
//
import SwiftUI

struct TaskRowView: View {
    
    let task: TaskModel
    
    
    
    var body: some View {
        HStack {
            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(task.isCompleted ? .green : .red)
            Text(task.title)
            // push items to the left
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 8)
    }
}

struct TaskRowView_Previews: PreviewProvider {
    
    static var task1 = TaskModel(title: "First item!", isCompleted: false)
    static var task2 = TaskModel(title: "Second item!", isCompleted: true)
    
    static var previews: some View {
        // group to preview different models
        Group {
            TaskRowView(task: task1)
            TaskRowView(task: task2)
        }
        .previewLayout(.sizeThatFits)
    }
}
