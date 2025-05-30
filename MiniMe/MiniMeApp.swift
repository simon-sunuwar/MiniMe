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
    @StateObject private var taskViewModel: TaskViewModel = TaskViewModel()
    @StateObject private var router = NavigationRouter()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(router)
                .environmentObject(taskViewModel)
        }
    }
}
