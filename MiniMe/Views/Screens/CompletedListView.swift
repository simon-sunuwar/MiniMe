//
//  CompletedListView.swift
//  MiniMe
//
//  Created by Simon on 2025-05-22.

import SwiftUI

struct CompletedListView: View {
    @EnvironmentObject var taskViewModel: TaskViewModel

    var body: some View {
        List {
            if taskViewModel.completedTasks.isEmpty {
                Text("No completed tasks yet")
                    .foregroundColor(.gray)
            } else {
                ForEach(taskViewModel.completedTasks) { task in
                    HStack {
                        Text(task.title)
                            .strikethrough()
                            .foregroundColor(.secondary)
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .navigationTitle("Completed")
    }
}


#Preview {
    CompletedListView()
        .environmentObject(TaskViewModel())
}
