//
//  ContentView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 15/12/2025.
//

import SwiftUI
import SwiftData

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
            Tab("Analysis", systemImage: "chart.xyaxis.line") {
                AnalysisView()
            }
            Tab("Settings", systemImage: "gearshape") {
                SettingsView()
            }
        }
    }
}

#Preview {
    WageAppView()
        .modelContainer(for: [Theme.self, Language.self, Currency.self], inMemory: true)
}
