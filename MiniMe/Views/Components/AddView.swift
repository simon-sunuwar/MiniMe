////
////  AddView.swift
////  MiniMe
////
////  Created by Simon on 2025-05-07.
////
//
//import SwiftUI
//
//struct AddView: View {
//    
//    // go back 1 on view higharchy
//    @Environment(\.presentationMode) var presentationMode
//    
//    @EnvironmentObject var taskViewModel: TaskViewModel
//    @State var textFieldText: String = ""
//    
//    @State var alertTitle: String = ""
//    @State var showAlert: Bool = false
//    
//    var body: some View {
//        ScrollView {
//            VStack {
//                TextField("Type Something...", text: $textFieldText)
//                    .padding(.horizontal)
//                    .frame(height: 55)
//                    .cornerRadius(10)
//                    .background(Color(UIColor.secondarySystemBackground))
//                    .cornerRadius(10)
//                
//                Button(action: saveButtonPressed, label: {
//                    Text("Save".uppercased())
//                        .foregroundColor(.white)
//                        .font(.headline)
//                        .frame(height: 55)
//                        .frame(maxWidth: .infinity)
//                        .background(Color.accentColor)
//                        .cornerRadius(10)
//                })
//            }
//            .padding(14)
//        }
//        .navigationTitle("Add an Item")
//        .alert(isPresented: $showAlert, content: getAlert)
//            
//    }
//    
//    func saveButtonPressed() {
//        // if true (don't have to add == true)
//        if textIsAppropriate(){
//            taskViewModel.addTask(title: textFieldText)
//            // go back 1 on view higharchy
//            presentationMode.wrappedValue.dismiss()
//        }
//    }
//    
//    // less than 3 letters does not add
//    func textIsAppropriate() -> Bool {
//        if textFieldText.count < 3 {
//            alertTitle = "Text must be at least 3 letters long."
//            showAlert.toggle()
//            return false
//        }
//        return true
//    }
//    
//    func getAlert() -> Alert {
//        return Alert(title: Text(alertTitle))
//    }
//}
//
//struct AddView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            NavigationView {
//                AddView()
//            }
//            .preferredColorScheme(.light)
//            .environmentObject(TaskViewModel())
//            NavigationView {
//                AddView()
//                   
//                
//            }
//            .preferredColorScheme(.dark)
//            .environmentObject(TaskViewModel())
//        }
//    }
//}
//
