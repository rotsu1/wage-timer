//
//  ContentView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 15/12/2025.
//

import SwiftUI
import SwiftData

struct WageAppView: View {
    @Query private var records: [Record]

    var body: some View {
        NavigationStack {
            TabView {
                Tab("Home", systemImage: "house") {
                    HomeView(records: records)
                }
                Tab("Calendar", systemImage: "calendar") {
                    CalendarView(records: records)
                }
                Tab("Add", systemImage: "plus") {
                    AddView(records: records)
                }
                Tab("Analysis", systemImage: "chart.xyaxis.line") {
                    AnalysisView(records: records)
                }
                Tab("Settings", systemImage: "gearshape") {
                    SettingsView()
                }
            }
        }
    }
}

#Preview {
    WageAppView()
        .modelContainer(for: [Theme.self, Language.self, Currency.self, Wage.self, NotificationSettings.self, Record.self, Analysis.self], inMemory: true)
}
