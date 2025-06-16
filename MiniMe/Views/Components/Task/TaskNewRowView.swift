import SwiftUI

struct NewTaskRow: View {
    var onAdd: () -> Void

    var body: some View {
        Button(action: {
            onAdd()
        }) {
            HStack {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.blue)
                Text("Add New Task")
                    .foregroundColor(.blue)
                    .fontWeight(.medium)
                Spacer()
            }
            .padding(.vertical, 8)
        }
    }
}
