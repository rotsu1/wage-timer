//
//  TodaysAppsView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 15/12/2025.
//
import SwiftUI
import SwiftData

struct TodaysAppsView: View {
    var todayRecords: [Record]
    @Query private var wages: [Wage]
    var wage: Int {
        if let existingWage = wages.first {
            return Int(existingWage.wage) ?? 1000
        }
        return 1000
    }

    var body: some View {
        VStack() {
            HStack {
                Text("今日使ったアプリ")
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
            }
            ForEach(groupRecordsByName(records: todayRecords)) { record in 
                card(
                    title: record.name, 
                    time: timeToString(time: record.totalTime), 
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

//#Preview {
//    TodaysAppsView(todayRecords: [])
//}
