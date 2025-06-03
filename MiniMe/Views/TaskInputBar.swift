import SwiftUI

struct TaskInputBar: View {
    @EnvironmentObject var taskViewModel: TaskViewModel
    @State private var alertTitle: String = ""
    @State private var showAlert = false
    
    @Binding var text: String
    
    @FocusState var isTextFieldFocused: Bool // Focus state inside the component
    
    var onCommit: (() -> Void)?
    
    var body: some View {
        VStack() {
            if showAlert {
                Text(alertTitle)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.horizontal)
            }
            HStack {
                TextField("New task...", text: $text)
                    .textFieldStyle(.roundedBorder)
                    .submitLabel(.done)
                    .focused($isTextFieldFocused) // <-- bind the focus here
                    .onSubmit {
                        addTask()
                    }

                Button(action: addTask) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background(Color.gray)
            .onAppear {
                // Automatically focus when the view appears
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isTextFieldFocused = true
                }
            }
    }

    private func addTask() {
        let trimmed = text.trimmingCharacters(in: .whitespaces)
        guard trimmed.count >= 3 else {
            alertTitle = "Text must be at least 3 letters long."
            showAlert = true
            return
        }

        taskViewModel.addTask(title: trimmed)
        text = ""
        showAlert = false
        onCommit?()
    }
}

#Preview {
    @State var sampleText = "Example task"
    
    return TaskInputBar(text: $sampleText)
        .environmentObject(TaskViewModel())
        .background(Color.gray.opacity(0.2)) // Optional: make layout clearer
}
