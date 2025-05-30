//
//  NavigationRouter.swift
//  MiniMe
//
//  Created by Simon on 2025-05-29.
//

import SwiftUI
class NavigationRouter: ObservableObject {
    @Published var selectedTab: TabViewEnum = .home
    @Published var isTabMenuVisible: Bool = false
    
    func toggleMenu() {
        isTabMenuVisible.toggle()
    }
}
