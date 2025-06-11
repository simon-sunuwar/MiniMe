
import SwiftUI

struct HomeScreen: View {
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
    HomeScreen()
        .environmentObject(TaskViewModel())
}
