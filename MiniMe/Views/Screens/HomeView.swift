
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var taskViewModel: TaskViewModel
    @State private var showMenu = false
    @State var selectedTab: Tab = .home
    @State private var newTaskTitle: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Home Content
                VStack(spacing: 0) {
                    ScrollView { // Optional, useful if content may overflow
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Home")
                                .font(.title)
                                .bold()
                            
                            // Avatar
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: 300)
                                .overlay(Text("Avatar Placeholder"))
                            
                            // Tasks
                            Text("Tasks")
                                .font(.title)
                                .bold()
                            
                            if taskViewModel.activeTasks.isEmpty {
                                
                                Text("There are no active Tasks")
                                
//                                    NavigationLink(
//                                        destination: AddView(),
//                                        label: {
//                                            Text("Add Task")
//                                                .foregroundColor(.primary)
//                                                .padding()
//                                                .frame(width: 150)
//                                                .background(Color.accentColor)
//                                                .cornerRadius(10)
//                                                .frame(maxWidth: .infinity)
//                                        })
                                
                            } else {
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
                                .frame(height: 200) // Adjust as needed
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 80) // Space for bottom bar
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(TaskViewModel())
}
