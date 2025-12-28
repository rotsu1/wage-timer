//
//  NotificationSettingsView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 21/12/2025.
//
import AppIntents
import SwiftData

struct StartRecordIntent: AppIntent {
    static var title: LocalizedStringResource = "記録を開始する"

    @Parameter(title: "記録名")
    var name: String

    static var parameterSummary: some ParameterSummary {
        Summary("\(\.$name) の記録を開始する")
    }

    func perform() async throws -> some IntentResult {
        await MainActor.run {
            let context = ModelContext(DataContainer.shared)

            let pending = PendingRecord(
                name: name,
                startDate: Date()
            )

            context.insert(pending)
            try? context.save()
        }

        return .result()
    }
}


struct StopRecordIntent: AppIntent {
    static var title: LocalizedStringResource = "記録を終了する"

    @Parameter(title: "記録名")
    var name: String

    static var parameterSummary: some ParameterSummary {
        Summary("\(\.$name) の記録を終了する")
    }

    func perform() async throws -> some IntentResult {
        await MainActor.run {
            let context = ModelContext(DataContainer.shared)

            let descriptor = FetchDescriptor<PendingRecord>(
                predicate: #Predicate { $0.name == name },
                sortBy: [SortDescriptor(\.startDate, order: .reverse)]
            )

            guard let pending = try? context.fetch(descriptor).first else {
                return
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
        }

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
                "\(.applicationName)で記録開始"
            ],
            shortTitle: "Start Record",
            systemImageName: "play.circle"
        )

        AppShortcut(
            intent: StopRecordIntent(),
            phrases: [
                "Stop record in \(.applicationName)",
                "End tracking in \(.applicationName)",
                "\(.applicationName)で記録終了"
            ],
            shortTitle: "Stop Record",
            systemImageName: "stop.circle"
        )
    }
}
