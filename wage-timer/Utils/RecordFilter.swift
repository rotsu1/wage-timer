//
//  RecordFilter.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 25/12/2025.
//
import Foundation

struct RecordFilter {
    let records: [Record]
    let currentDate: Date
    let calendar: Calendar = {
        var c = Calendar.current
        c.firstWeekday = 2
        return c
    }()
    
    private func filterRecords(from start: Date, duration: Calendar.Component, value: Int) -> [Record] {
        let end = calendar.date(byAdding: duration, value: value, to: start) ?? start
        return records.filter { $0.startDate >= start && $0.startDate < end }
    }

    var today: [Record] {
        let start = calendar.startOfDay(for: currentDate)
        return filterRecords(from: start, duration: .day, value: 1)
    }
    
    var thisWeek: [Record] {
        let start = calendar.dateInterval(of: .weekOfYear, for: currentDate)?.start ?? currentDate
        return filterRecords(from: start, duration: .day, value: 7)
    }
    
    var thisMonth: [Record] {
        let start = calendar.dateInterval(of: .month, for: currentDate)?.start ?? currentDate
        return filterRecords(from: start, duration: .month, value: 1)
    }

    var thisYear: [Record] {
        let start = calendar.dateInterval(of: .year, for: currentDate)?.start ?? currentDate
        return filterRecords(from: start, duration: .year, value: 1)
    }

    var lastWeek: [Record] {
        let thisWeekStart = calendar.dateInterval(of: .weekOfYear, for: currentDate)?.start ?? currentDate
        let start = calendar.date(byAdding: .weekOfYear, value: -1, to: thisWeekStart) ?? thisWeekStart
        return records.filter { $0.startDate >= start && $0.startDate < thisWeekStart }
    }

    var lastMonth: [Record] {
        let thisMonthStart = calendar.dateInterval(of: .month, for: currentDate)?.start ?? currentDate
        let start = calendar.date(byAdding: .month, value: -1, to: thisMonthStart) ?? thisMonthStart
        return records.filter { $0.startDate >= start && $0.startDate < thisMonthStart }
    }
}