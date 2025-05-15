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
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(listViewModel)   // has acces to ListViewModel
        }
    }
}
