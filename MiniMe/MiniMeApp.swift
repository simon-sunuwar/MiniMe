//
//  MiniMeApp.swift
//  MiniMe
//
//  Created by Simon on 2025-04-30.
//

/*
 MVVM Architecture
 Model - Data Point
 View - UI
 ViewModel - UI Logic
 */

import SwiftUI

@main
struct MiniMeApp: App {
    
    @StateObject var taskViewModel: TaskViewModel = TaskViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeViewModel()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(taskViewModel)   // has acces to ListViewModel
        }
    }
}
