//
//  SideMenuView.swift
//  MiniMe
//
//  Created by Simon on 2025-05-27.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var showMenu: Bool
    
    var body: some View {
        ZStack {
                    // Bottom sheet menu
                    VStack(spacing: 20) {
                        Capsule()
                            .fill(Color.gray.opacity(0.5))
                            .frame(width: 40, height: 6)
                            .padding(.top, 10)
                        
                        NavigationLink(destination: CompletedListView()) {
                            Text("Completed List")
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .shadow(radius: 20)
                    .transition(.move(edge: .bottom))
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
                .animation(.easeInOut, value: showMenu)
                .zIndex(1)
               
            }
    }

#Preview {
    SideMenuView(showMenu: .constant(true))
}
