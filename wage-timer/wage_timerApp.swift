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
    let notificationSettings = NotificationSettings()

    var body: some Scene {
        WindowGroup {
            WageAppView()
                .modelContainer(for: [Theme.self, Language.self, Currency.self, Wage.self, Record.self, Analysis.self])
                .onAppear {
                    notificationSettings.requestNotificationRequest()
                }
        }
    }
}
