//
//  CompletedListView.swift
//  MiniMe
//
//  Created by Simon on 2025-05-22.
//
//
//import SwiftUI
//
//struct CompletedListView: View {
//    @EnvironmentObject var listViewModel: ListViewModel
//
//    var body: some View {
//        List {
//            ForEach(listViewModel.completedList) { item in
//                ListRowView(item: item) // Reuse the same view
//            }
//            .onDelete(perform: deleteItem)
//        }
//        .navigationTitle("Completed Tasks")
//    }
//
//    func deleteItem(at offsets: IndexSet) {
//        listViewModel.completedList.remove(atOffsets: offsets)
//    }
//}
//
//
//#Preview {
//    CompletedListView()
//        .environmentObject(ListViewModel())
//}
