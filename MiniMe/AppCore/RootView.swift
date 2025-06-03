import SwiftUI

struct RootView: View {
    @EnvironmentObject var router: NavigationRouter
    @EnvironmentObject var taskViewModel: TaskViewModel

    @State private var showTaskInputBar = false
    @State private var newTaskTitle = ""
    @FocusState private var isTaskInputFocused: Bool

    var body: some View {
        ZStack {
            // Main content based on selected tab
            Group {
                switch router.selectedTab {
                case .home: HomeView()
                case .completedList: CompletedListView()
                case .calendar: CalendarView()
                default: EmptyView()
                }
                
                // ✅ Task Input Bar that moves with keyboard
                if showTaskInputBar {
                    ZStack {
                        // Transparent tap area to dismiss
                        Color.black.opacity(0.001)
                            .ignoresSafeArea()
                            .onTapGesture {
                                showTaskInputBar = false
                            }

                        // Task input bar anchored at bottom
                        VStack {
                            Spacer()
                            TaskInputBar(
                                text: $newTaskTitle,
                                onCommit: {
                                    showTaskInputBar = false
                                }
                            )
                        }
                    }
                    .transition(.move(edge: .bottom))
                    .zIndex(3)
                }
                
                // ✅ Fixed-bottom layer that ignores keyboard
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        FloatingAddButtonView {
                            showTaskInputBar = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                isTaskInputFocused = true
                            }
                        }
                        .padding(.trailing, 24)
                        .padding(.bottom, 10) // above tab bar
                    }
                    
                    // Tab Bar
                    tabBar
                }
                .ignoresSafeArea(.keyboard, edges: .bottom) // ✅ Only this layer ignores keyboard
                .zIndex(2)
                
                // Tab menu overlay (if any)
                if router.isTabMenuVisible {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            router.isTabMenuVisible = false
                        }
                        .zIndex(1)
                    
                    VStack {
                        Spacer()
                        TabBarMenuView()
                            .transition(.move(edge: .bottom))
                            .padding(.bottom, 65)
                            .animation(.easeInOut(duration: 0.3), value: router.isTabMenuVisible)
                    }
                }
            }
            
        }
    }
    // MARK: - Tab Bar View
    private var tabBar: some View {
        HStack {
            ForEach(TabViewEnum.allCases) { tab in
                tabButton(for: tab)
            }
        }
        .padding()
        .background(Color(.systemGray6))
    }

    // MARK: - Tab Button View
    @ViewBuilder
    private func tabButton(for tab: TabViewEnum) -> some View {
        Button(action: {
            if tab == .tabMenu {
                withAnimation {
                    router.toggleMenu()
                }
            } else {
                router.selectedTab = tab
                router.isTabMenuVisible = false
            }
        }) {
            VStack {
                Image(systemName: tab.icon)
                Text(tab.label)
                    .font(.caption)
            }
            .foregroundColor(router.selectedTab == tab ? .blue : .gray)
            .frame(maxWidth: .infinity)
        }
    }
}


#Preview {
    RootView()
        .environmentObject(TaskViewModel())
        .environmentObject(NavigationRouter())
}
