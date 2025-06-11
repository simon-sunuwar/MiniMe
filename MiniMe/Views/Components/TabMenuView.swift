import SwiftUI

struct TabMenuView: View {
    var body: some View {
        VStack(spacing: 20) {
//            NavigationLink(destination: CompletedListView()) {
//                Text("Completed List")
//                    .foregroundColor(.primary)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .cornerRadius(10)
//            }
            // Add more menu buttons here
        }
        .frame(maxWidth: .infinity)
        .frame(height: 300) // fixed height for the bottom sheet
        .background(Color.tabBarDarkGray)
    }
}

#Preview {
    TabMenuView()
}
