//
//  SummaryView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 15/12/2025.
//
import SwiftUI
import SwiftData

private func homeCard(title: String, main: String, description: String) -> some View {
    VStack(alignment: .leading) {
        Text(title)
        Spacer()
        Text(main)
            .fontWeight(.bold)
        Spacer()
        Text(description)
    }
    .lineLimit(1)
    .minimumScaleFactor(0.5)
    .frame(maxWidth: .infinity, minHeight: 80, alignment: .leading)
    .padding()
    .overlay(
        RoundedRectangle(cornerRadius: 20)
            .stroke(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.3))
    )
    .background(
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.2))
    )
}

struct SummaryView: View {
    @Query private var wages: [Wage]
    var wage: Int {
        if let existingWage = wages.first {
            return Int(existingWage.wage) ?? 1000
        }
        return 1000
    }
    var todayRecords: [Record]
    var weeklyRecords: [Record]
    var monthlyRecords: [Record]
    var lastWeeklyRecords: [Record]
    var lastMonthlyRecords: [Record] 

    private func totalTime(records: [Record]) -> Int {
        return records.reduce(0) { $0 + $1.time }
    }

    private func getMostUsed(_ records: [Record]) -> (name: String, description: String) {
        let groupedByName = groupRecordsByName(records: monthlyRecords)
        let mostUsed = groupedByName.max { $0.totalTime < $1.totalTime }
        let mostUsedDescription = mostUsed.map { timeToString(time: $0.totalTime) }
        return (mostUsed?.name ?? "なし", mostUsedDescription ?? "なし")
    }

    private func getAverage(_ records: [Record]) -> (use: String, time: String) {
        let totalRecords = records.count
        let totalDays = groupRecordsByDay(records: records).count
        let averageUse = totalDays > 0 
            ? roundToX(Double(totalRecords) / Double(totalDays), point: 2) 
            : 0
        let totalTime = records.reduce(0) { $0 + $1.time }
        let averageTime = totalDays > 0 ? totalTime / totalDays : 0
        return (averageUse == 0.0 ? "0" : String(averageUse), lossToString(time: averageTime, wage: wage))
    }

    private func getComparison(_ current: [Record], _ past: [Record]) -> String {
        let currentTotal = current.reduce(0) { $0 + $1.time }
        let pastTotal = past.reduce(0) { $0 + $1.time }
        
        guard pastTotal != 0 else {
            return "なし"
        }
        
        let change = Double(pastTotal - currentTotal) / Double(pastTotal) * 100
        return String(format: "%+.0f%%", change) // + or - automatically
    }

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("今日のマイナス")
                    Text(lossToString(time: totalTime(records: todayRecords), wage: wage))
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                }
                Spacer()
                VStack {
                    VStack {
                        Text("前週比 \(getComparison(weeklyRecords, lastWeeklyRecords))")
                            .fontWeight(.bold)
                    }
                    .padding(.all, 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.3))
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.3))
                    )
                    VStack {
                        Text("前月比 \(getComparison(monthlyRecords, lastMonthlyRecords))")
                            .fontWeight(.bold)
                    }
                    .padding(.all, 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.3))
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.3))
                    )
                }
            }
            .padding(.bottom, 16)
            HStack(spacing: 16) {
                let weekyTime = totalTime(records: weeklyRecords)
                let monthlyTime = totalTime(records: monthlyRecords)
                homeCard(
                    title: "今週", 
                    main: lossToString(time: weekyTime, wage: wage), 
                    description: timeToString(time: weekyTime)
                )
                homeCard(
                    title: "今月", 
                    main: lossToString(time: monthlyTime, wage: wage),
                    description: timeToString(time: monthlyTime)
                )
            }
            HStack {
                let mostUsed = getMostUsed(monthlyRecords)
                homeCard(
                    title: "今月一番使ったアプリ",
                    main: mostUsed.name,
                    description: mostUsed.description
                )

                let average = getAverage(monthlyRecords)
                homeCard(
                    title: "今月の開いた回数の平均",
                    main: average.use,
                    description: average.time
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

// #Preview {
//     SummaryView(todayRecords: [])
// }
