//
//  CalendarHelper.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 25/12/2025.
//
import Foundation
import SwiftUI

struct CalendarHelper {
    let currentDate: Date

    var day: String {
        currentDate.formatted(Date.FormatStyle().day(.defaultDigits))
    }

    var month: String { 
        currentDate.formatted(Date.FormatStyle().month(.defaultDigits))
    }

    var year: String {
        currentDate.formatted(Date.FormatStyle().year(.defaultDigits))
    }

    var firstWeekday: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        let firstOfMonth = calendar.date(from: components)!
        return calendar.component(.weekday, from: firstOfMonth)
    }

    var numberOfDays: Array<Int> {
        let calendar = Calendar.current
        guard let range = calendar.range(of: .day, in: .month, for: currentDate) else {
            return []
        }
        return Array(range)
    }

    let weekdays = [
        String(localized: "Sun"), 
        String(localized: "Mon"), 
        String(localized: "Tue"), 
        String(localized: "Wed"), 
        String(localized: "Thu"), 
        String(localized: "Fri"), 
        String(localized: "Sat")
    ]

    let columns = Array(repeating: GridItem(.flexible()), count: 7)
}
