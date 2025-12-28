//
//  NotificationSettingsView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 21/12/2025.
//
import AppIntents
import SwiftData

struct StartRecordIntent: AppIntent {
    static var title: LocalizedStringResource = "Start recording"

    @Parameter(title: "Name of App")
    var name: String

    static var parameterSummary: some ParameterSummary {
        Summary("Start recording \(\.$name)")
    }

    func perform() async throws -> some IntentResult {
        let context = ModelContext(DataContainer.shared)

        let pending = PendingRecord(
            name: name,
            startDate: Date()
        )

        context.insert(pending)
        try? context.save()

        return .result()
    }
}


struct StopRecordIntent: AppIntent {
    static var title: LocalizedStringResource = "Stop recording"

    @Parameter(title: "Name of App")
    var name: String

    static var parameterSummary: some ParameterSummary {
        Summary("Stop recording \(\.$name)")
    }

    func perform() async throws -> some IntentResult {
        let context = ModelContext(DataContainer.shared)

        let descriptor = FetchDescriptor<PendingRecord>(
            predicate: #Predicate { $0.name == name },
            sortBy: [SortDescriptor(\.startDate, order: .reverse)]
        )

        guard let pending = try? context.fetch(descriptor).first else {
            return .result()
        }

        let seconds = Date().timeIntervalSince(pending.startDate)
        let minutes = max(1, Int(seconds / 60))

        let record = Record(
            name: pending.name,
            startDate: pending.startDate,
            time: minutes
        )

        context.insert(record)
        context.delete(pending)
        try? context.save()

        return .result()
    }
}


import AppIntents

struct MyAppShortcuts: AppShortcutsProvider {

    @AppShortcutsBuilder
    static var appShortcuts: [AppShortcut] {

        AppShortcut(
            intent: StartRecordIntent(),
            phrases: [
                "Start record in \(.applicationName)",
                "Begin tracking in \(.applicationName)",
            ],
            shortTitle: "Start Record",
            systemImageName: "play.circle"
        )

        AppShortcut(
            intent: StopRecordIntent(),
            phrases: [
                "Stop record in \(.applicationName)",
                "End tracking in \(.applicationName)",
            ],
            shortTitle: "Stop Record",
            systemImageName: "stop.circle"
        )
    }
}
