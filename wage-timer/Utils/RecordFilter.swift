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
    
    var today: [Record] {
        let start = calendar.startOfDay(for: currentDate)
        let end = calendar.date(byAdding: .day, value: 1, to: start) ?? start
        return records.filter { $0.startDate >= start && $0.startDate < end }
    }
    
    var thisWeek: [Record] {
        let start = calendar.dateInterval(of: .weekOfYear, for: currentDate)?.start ?? currentDate
        let end = calendar.date(byAdding: .day, value: 6, to: start) ?? start
        return records.filter { $0.startDate >= start && $0.startDate < end }
    }
    
    var thisMonth: [Record] {
        let start = calendar.dateInterval(of: .month, for: currentDate)?.start ?? currentDate
        let end = calendar.date(byAdding: .month, value: 1, to: start).flatMap {
            calendar.date(byAdding: .second, value: -1, to: $0)
        } ?? start
        return records.filter { $0.startDate >= start && $0.startDate <= end }
    }

    var thisYear: [Record] {
        let start = calendar.dateInterval(of: .year, for: currentDate)?.start ?? currentDate
        let end = calendar.date(byAdding: .year, value: 1, to: start).flatMap {
            calendar.date(byAdding: .second, value: -1, to: $0)
        } ?? start
        return records.filter { $0.startDate >= start && $0.startDate <= end }
    }

    var lastWeek: [Record] {
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: currentDate)?.start ?? currentDate
        let start = calendar.date(byAdding: .day, value: -7, to: startOfWeek) ?? startOfWeek
        let end = calendar.date(byAdding: .day, value: -1, to: startOfWeek) ?? startOfWeek
        return records.filter { $0.startDate >= start && $0.startDate <= end }
    }

    var lastMonth: [Record] {
        let startOfMonth = calendar.dateInterval(of: .month, for: currentDate)?.start ?? currentDate
        let lastMonth = calendar.date(byAdding: .second, value: -1, to: startOfMonth) ?? startOfMonth
        let start = calendar.dateInterval(of: .month, for: lastMonth)?.start ?? lastMonth
        let end = calendar.date(byAdding: .second, value: -1, to: startOfMonth) ?? startOfMonth
        return records.filter { $0.startDate >= start && $0.startDate <= end }
    }
}
