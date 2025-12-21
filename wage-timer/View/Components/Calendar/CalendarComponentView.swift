//
//  CalendarView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 18/12/2025.
//

import SwiftUI

let numberOfCells = 6 * 7

struct CalendarComponentView: View {
    var calendar: Calendar { Calendar.current }
    var now: Date { Date() }
    var day: String { now.formatted(Date.FormatStyle().day(.defaultDigits)) }
    var month: String { now.formatted(Date.FormatStyle().month(.defaultDigits)) }
    var year: String { now.formatted(Date.FormatStyle().year(.defaultDigits)) }
    var firstDayOfMonthWeekday: Int {
        var components = DateComponents()
        components.year = Int(year)
        components.month = Int(month)
        components.day = 1

        var weekday = 0
        if let date = calendar.date(from: components) {
            // 2. Ask the calendar for the weekday of that date
            weekday = calendar.component(.weekday, from: date)
        }
        return weekday
    }
    var numberOfDays: Array<Int> { Array(calendar.range(of: .day, in: .month, for: now) ?? 1..<1) }
    let weekdays = ["日", "月", "火", "水", "木", "金", "土"]
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.left")
                Spacer()
                Text("2025年12月")
                Spacer()
                Image(systemName: "arrow.right")
            }
            .padding()
            LazyVGrid(columns: columns) {
                ForEach(weekdays, id: \.self) { day in
                    VStack {
                        Spacer()
                        Text(day)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            LazyVGrid(columns: columns) {
                ForEach(1...numberOfCells, id: \.self) { day in
                    if day < firstDayOfMonthWeekday {
                        Text("")
                    } else if day > numberOfDays.count + firstDayOfMonthWeekday - 1 {
                        Text("")
                    } else {
                        VStack {
                            Spacer()
                            Text("\(day - firstDayOfMonthWeekday + 1)")
                            Spacer()
                            Text("")
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.3))
                        )
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

#Preview {
    CalendarComponentView()
}
