//
//  TodaysAppsView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 15/12/2025.
//
import SwiftUI
import SwiftData

struct RecordSummary: Identifiable {
    let id = UUID()
    let name: String
    let totalTime: Int
    let occurance: Int
}

struct TodaysAppsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var wages: [Wage]

    private static let calendar = Calendar.current
    private static let startOfToday = calendar.startOfDay(for: Date())
    private static let startOfTomorrow = calendar.date(byAdding: .day, value: 1, to: startOfToday)!

    @Query(
        filter: #Predicate<Record> {
            $0.startDate >= startOfToday &&
            $0.startDate < startOfTomorrow
        }
    )
    private var todayRecords: [Record]

    var wage: Int {
        if let existingWage = wages.first {
            return Int(existingWage.wage) ?? 1000
        }
        return 1000
    }

    var groupedRecords: [RecordSummary] {
        let grouped = Dictionary(grouping: todayRecords, by: { $0.name })
        
        return grouped.map { (name, records) in
            RecordSummary(
                name: name,
                totalTime: records.reduce(0) { $0 + $1.time },
                occurance: records.count
            )
        }
    }

    var body: some View {
        VStack() {
            HStack {
                Text("今日使ったアプリ")
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
            }
            ForEach(groupedRecords) { record in 
                card(
                    title: record.name, 
                    time: toTime(time: record.totalTime), 
                    occurance: String(record.occurance), 
                    money: lossToString(time: record.totalTime, wage: wage)
                )
            }

        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.3))
        )
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.1))
        )
        .foregroundStyle(.white)
    }
}

#Preview {
    TodaysAppsView()
}
