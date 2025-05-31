//
//  TabViewEnum.swift
//  MiniMe
//
//  Created by Simon on 2025-05-29.
//

import SwiftUI

enum TabViewEnum: Int, CaseIterable, Identifiable {
    case home
    case completedList
    case calendar
    case tabMenu

    var id: Int { rawValue }

    var label: String {
        switch self {
        case .home: return "Home"
        case .completedList: return "Completed"
        case .calendar: return "Calendar"
        case .tabMenu: return ""
        }
    }

    var icon: String {
        switch self {
        case .home: return "house"
        case .completedList: return "checkmark.circle"
        case .calendar: return "calendar"
        case .tabMenu: return "line.horizontal.3"
        }
    }

    @ViewBuilder
    var view: some View {
        switch self {
        case .home:             HomeView()
        case .completedList:    CompletedListView()
        case .calendar:         CalendarView()
        case .tabMenu:          EmptyView()
        }
    }
}
