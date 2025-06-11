//
//  TabViewEnum.swift
//  MiniMe
//
//  Created by Simon on 2025-05-29.
//

import SwiftUI

enum TabViewEnum: Int, CaseIterable, Identifiable {
    case home
//    case completedList
    case calendar
    case tabMenu
    case todolist

    var id: Int { rawValue }

    var label: String {
        switch self {
        case .home: return "Home"
//        case .completedList: return "Completed"
        case .calendar: return "Calendar"
        case .tabMenu: return ""
        case .todolist: return "Today"
        
        }
    }

    var icon: String {
        switch self {
        case .home: return "house"
//        case .completedList: return "checkmark.circle"
        case .calendar: return "calendar"
        case .tabMenu: return "line.horizontal.3"
        case .todolist: return "list.bullet"
        }
    }

    @ViewBuilder
    var view: some View {
        switch self {
        case .home:             HomeScreen()
//        case .completedList:    CompletedListView()
        case .calendar:         CalendarView()
        case .tabMenu:          EmptyView()
        case .todolist:         ToDoListScreen()
        }
    }
}
