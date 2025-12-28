//
//  CalendarView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 18/12/2025.
//
import SwiftUI
import SwiftData

let numberOfCells = 6 * 7

struct CalendarComponentView: View {
    @Binding var currentDate: Date
    var records: [Record]
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

    var calendarHelper: CalendarHelper { CalendarHelper(currentDate: currentDate) }

    var dailySummaries: [Int: Int] {
        let filter = RecordFilter(records: records, currentDate: currentDate)
        let monthlyRecords = filter.thisMonth
        
        let calendar = Calendar.current
        var summaries: [Int: Int] = [:]
        
        for record in monthlyRecords {
            let day = calendar.component(.day, from: record.startDate)
            summaries[day, default: 0] += record.time
        }
        
        return summaries
    }

    func changeMonth(_ value: Int) -> Void {
        let calendar = Calendar.current
        if let nextMonth = calendar.date(byAdding: .month, value: value, to: currentDate) {
            let start = calendar.dateInterval(of: .month, for: nextMonth)?.start ?? nextMonth
            currentDate = start
        }
    }

    func changeDay(_ day: Int) -> Void {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month], from: currentDate)
        components.day = day

        currentDate = calendar.date(from: components) ?? currentDate
    }

    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM"
        return formatter
    }()
     
    var body: some View {
        VStack {
            HStack {
                Button {
                    changeMonth(-1)
                } label: {
                    Image(systemName: "arrow.left")
                }
                Spacer()
                Text(formatter.string(from: currentDate))
                Spacer()
                Button {
                    changeMonth(1)
                } label: {
                    Image(systemName: "arrow.right")
                }
            }
            .padding()
            LazyVGrid(columns: calendarHelper.columns) {
                ForEach(calendarHelper.weekdays, id: \.self) { day in
                    VStack {
                        Spacer()
                        Text(day)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            LazyVGrid(columns: calendarHelper.columns) {
                let firstWeekday = calendarHelper.firstWeekday
                let daysCount = calendarHelper.numberOfDays.count

                let summaries = dailySummaries
                let calendar = Calendar.current
                let currentDayComponent = calendar.component(.day, from: currentDate)

                ForEach(1...numberOfCells, id: \.self) { day in
                    let acutualDay = day - firstWeekday + 1
                    
                    if day < firstWeekday || day > daysCount + firstWeekday - 1 {
                        Text("")
                            .frame(maxWidth: .infinity, minHeight: 60)
                    } else {
                        Button {
                            changeDay(acutualDay)
                        } label: {
                            let totalTime = summaries[acutualDay] ?? 0
                            let isSelected = (acutualDay == currentDayComponent)
                            let loss = lossToString(
                                            time: totalTime, 
                                            wage: wage,
                                            currency: currency
                                        )
                            
                            VStack {
                                Spacer()
                                Text("\(acutualDay)")
                                Spacer()
                                Text(
                                    loss == "\(currency)0" ? "" : loss
                                )
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, minHeight: 60)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(
                                        isSelected 
                                        ? Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.2) 
                                        : Color.clear
                                    )
                            )
                        }
                    }
                }
            }
        }
        .foregroundStyle(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.3))
        )
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.1))
        )
    }
}

//#Preview {
//    CalendarComponentView()
//}
