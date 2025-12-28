//
//  CalendarView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 18/12/2025.
//

import SwiftUI
import SwiftData

struct CalendarDaySummaryView: View {
    @Query private var wages: [Wage]
    var wage: Int {
        if let existingWage = wages.first {
            return Int(existingWage.wage) ?? 1000
        }
        return 1000
    }
    @Query private var currencies: [Currency]
    var currency: String {
        if let existingCurrency = currencies.first {
            return existingCurrency.currency
        }
        return "¥"
    }

    @Binding var currentDate: Date
    var records: [Record]

    var filter: RecordFilter { RecordFilter(records: records, currentDate: currentDate) }

    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        return formatter
    }()

    var body: some View {
        VStack {
            HStack {
                Text(formatter.string(from: currentDate))
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
            }
            HStack {
                let todayTime = filter.today.reduce(0) { $0 + $1.time }
                Text("損失: \(lossToString(time: todayTime, wage: wage, currency: currency))")
                Spacer()
            }
            ForEach(filter.today) { record in
                NavigationLink(destination: EditInputView(records: records, record: record)) {
                    card(
                        title: record.name,
                        time: timeToString(time: record.time),
                        money: lossToString(time: record.time, wage: wage, currency: currency)
                    )
                }
            }

        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.3))
        )
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.1))
        )
        .foregroundStyle(Color.white)
    }
}

//#Preview {
//    CalendarDaySummaryView()
//}
