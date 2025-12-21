//
//  ContentView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 15/12/2025.
//

import SwiftUI

struct WageAppView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                HomeView()
            }
            Tab("Calendar", systemImage: "calendar") {
                CalendarView()
            }
            Tab("Add", systemImage: "plus") {
                AddView()
            }
        }
    }
}

#Preview {
    WageAppView()
}
