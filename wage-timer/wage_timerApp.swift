//
//  wage_timerApp.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 15/12/2025.
//

import SwiftUI
import SwiftData

@main
struct wage_timerApp: App {
    @Query private var themes: [Theme]
    @Environment(\.modelContext) private var modelContext

    var body: some Scene {
        WindowGroup {
            WageAppView()
                .modelContainer(for: Theme.self)
                .task {
                    initTheme()
                }
        }
    }

    private func initTheme() {
        guard themes.isEmpty else { return }

        let theme = Theme(theme: "dark")
        modelContext.insert(theme)
    }
}
