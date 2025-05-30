//
//  AppConstant.swift
//  MiniMe
//
//  Created by Simon on 2025-05-28.
//

import SwiftUI

enum Tab: Int, Identifiable, CaseIterable {
    
    var id: Int {
        self.rawValue
    }
    
    case home
    case completedList
    
    var label: String {
        switch self {
            case .home: "home"
            case .completedList: "completed"
        }
    }

    var icon: String {
        switch self {
            case .home: return "house"
            case .completedList: return "magnifyingglass"
        }
    }
}

// MARK: - Shared Colors
extension Color {
    static let tabBarDarkGray = Color(red: 0.15, green: 0.15, blue: 0.15)
    static let brandBlue = Color("BrandBlue") // from Assets
}

// MARK: - Padding / Layout
struct Layout {
    static let horizontalPadding: CGFloat = 16
    static let tabBarHeight: CGFloat = 70
}


