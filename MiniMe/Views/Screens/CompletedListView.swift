//
//  CompletedListView.swift
//  MiniMe
//
//  Created by Simon on 2025-05-22.
//
//import SwiftUI
//
//struct CompletedListView: View {
//    @EnvironmentObject var taskViewModel: TaskViewModel
//    
//    var body: some View {
//        VStack {
//            if taskViewModel.completedTasks.isEmpty {
//                Text("No tasks to show!")
//            } else {
//                Text("Completed")
//                    .font(.headline)
//                List {
//                    ForEach($taskViewModel.tasks) { $task in
//                                            if task.isCompleted {
//                                                TaskRowView(task: $task)
//                                            }
//                                        }
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    CompletedListView()
//        .environmentObject(TaskViewModel())
//}
