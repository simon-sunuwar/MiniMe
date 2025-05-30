import SwiftUI

struct RootView: View {
    @EnvironmentObject var router: NavigationRouter

    var body: some View {
        ZStack {
            // Main content based on selected tab
            Group {
                switch router.selectedTab {
                case .home:
                    HomeView()
                case .completedList:
                    CompletedListView()
                default:
                    EmptyView()
                }
            }
            
            
            
            // Sidebar
            VStack {
                if router.isTabMenuVisible {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            router.isTabMenuVisible = false
                        }
                        .zIndex(1)
                    Spacer()
                    TabBarMenuView()
                        .transition(.move(edge: .bottom))
                        .padding(.bottom, 65)
                        .animation(.easeInOut(duration: 0.3), value: router.isTabMenuVisible)
                }
            }

            // Custom tab bar
            VStack {
                Spacer()
                tabBar
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
                withAnimation{
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
