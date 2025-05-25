//
//  HomeViewModel.swift
//  MiniMe
//
//  Created by Simon on 2025-05-15.
//

import SwiftUI

struct HomeViewModel: View {
    @EnvironmentObject var taskViewModel: TaskViewModel
    
    var body: some View {
        NavigationStack {
            VStack {

                Text("Home")
                    .font(.title)
                    .bold()
                
                // Top Avatar Placeholder
                VStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 300)
                        .overlay(Text("Avatar Placeholder"))
                }
                
                Text("Tasks")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                // Task Menu
                ZStack {
                    VStack {
                                if taskViewModel.tasks.isEmpty {
                                    NoItemsView()
                                } else {
                                    // Incomplete section
                                    Text("To Do")
                                        .font(.headline)
                                    List {
                                        ForEach(taskViewModel.activeTasks) { task in
                                            TaskRowView(task: task)
                                                .onTapGesture {
                                                    withAnimation {
                                                        taskViewModel.toggleCompleteTask(task: task)
                                                    }
                                                }
                                        }
                                        .onDelete(perform: taskViewModel.deleteTask)
                                        .onMove(perform: taskViewModel.moveTask)
                                    }

                                    // Completed section
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
                             

                // Bottom Navigation Button
                Button(action: {
                    // Open nav menu
                    print("Open nav menu")
                }) {
                    HStack {
                        Image(systemName: "line.horizontal.3")
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
            }
            .padding(.horizontal)
            
//            .navigationTitle("Home")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbarBackground(Color.white, for: .navigationBar)
//            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    HomeViewModel()
        .environmentObject(TaskViewModel())
}
