//
//  CompletedListView.swift
//  MiniMe
//
//  Created by Simon on 2025-05-22.

import SwiftUI

struct CompletedListView: View {
    @EnvironmentObject var taskViewModel: TaskViewModel
    
    var body: some View {
        VStack {
            if taskViewModel.completedTasks.isEmpty {
                Text("No tasks to show!")
            } else {
                Text("Completed")
                    .font(.headline)
                List {
                    ForEach(taskViewModel.completedTasks) { task in
                        TaskRowView(task: task)
                            .onTapGesture {
                                withAnimation {
                                    taskViewModel.toggleCompleteTask(task: task)
                                }
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    CompletedListView()
        .environmentObject(TaskViewModel())
}
