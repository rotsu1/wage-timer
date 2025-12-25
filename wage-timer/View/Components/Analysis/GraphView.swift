//
//  GraphView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 21/12/2025.
//

import SwiftUI
import SwiftData

struct ValuePerCategory {
    var category: String
    var value: Double
}

struct GraphView: View {
    var records: [Record]
    @Query private var analysisData: [Analysis]
    @Query private var wages: [Wage]
    var wage: Int {
        if let existingWage = wages.first {
            return Int(existingWage.wage) ?? 1000
        }
        return 1000
    }

    var todayYear: Int {
        let today = Date()
        let calendar = Calendar.current
        return calendar.component(.year, from: today)
    }

    private var currentContext: (year: Int, month: Int?) {
        if let existingAnalysis = analysisData.first {
            return (existingAnalysis.year, existingAnalysis.month)
        }
        return (todayYear, nil)
    }

    private var chartData: [ValuePerCategory] {
        let (year, month) = currentContext
        
        if let month = month {
            return getMonthData(year: year, month: month)
        } else {
            return getYearData(year: year)
        }
    }
    
    private var totalLossString: String {
        let (year, month) = currentContext
        let filter = getFilter(year: year, month: month)
        
        let totalTime: Int
        if month != nil {
             totalTime = filter.thisMonth.reduce(0) { $0 + $1.time }
        } else {
             totalTime = filter.thisYear.reduce(0) { $0 + $1.time }
        }
        
        let loss = lossToString(time: totalTime, wage: wage)
        return "\(loss)"
    }

    private func getFilter(year: Int, month: Int? = nil) -> RecordFilter {
        let calendar = Calendar.current
        let date: Date

        if month != nil {
            date = calendar.date(from: DateComponents(year: year, month: month)) ?? Date()
        } else {
            date = calendar.date(from: DateComponents(year: year)) ?? Date()
        }
        
        return RecordFilter(records: records, currentDate: date)
    }

    private func getYearData(year: Int) -> [ValuePerCategory] {
        let filter = getFilter(year: year)

        let yearlyData = filter.thisYear
        let groupedByMonth = groupRecordsByMonth(records: yearlyData)
        
        let data: [ValuePerCategory] = (1...12).map { month in
            if let existingSummary = groupedByMonth.first(where: { Int($0.name) == month }) {
                return ValuePerCategory(
                    category: "\(existingSummary.name)月",
                    value: timeWageToDoubleLoss(
                        time: existingSummary.totalTime,
                        wage: wage
                    )
                )
            } else {
                return ValuePerCategory(category: "\(month)月", value: 0)
            }
        }
        return data
    }

    private func getMonthData(year: Int, month: Int) -> [ValuePerCategory] {
        let filter = getFilter(year: year, month: month)
        let monthlyData = filter.thisMonth
        
        let groupedByDay = groupRecordsByDay(records: monthlyData) 
        
        let calendar = Calendar.current
        let dateComponents = DateComponents(year: year, month: month)
        let date = calendar.date(from: dateComponents) ?? Date()
        let range = calendar.range(of: .day, in: .month, for: date) ?? 1..<31
        
        let data: [ValuePerCategory] = range.map { day in
            if let existingSummary = groupedByDay.first(where: { Int($0.name) == day }) {
                return ValuePerCategory(
                    category: "\(existingSummary.name)日",
                    value: timeWageToDoubleLoss(
                        time: existingSummary.totalTime,
                        wage: wage
                    )
                )
            } else {
                return ValuePerCategory(category: "\(day)日", value: 0)
            }
        }
        return data
    }

    var body: some View {
        VStack {
            HStack {
                Text("収支")
                Spacer()
            }
            HStack {
                Text(totalLossString)
                    .foregroundStyle(.red)
                Spacer()
            }
            ChartView(data: chartData)
                .frame(minHeight: 200, maxHeight: 500)
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
        .foregroundStyle(.white)
    }
}

//#Preview {
//    GraphView()
//}
