//
//  HomeView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 18/12/2025.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var wages: [Wage]

    var wage: Int {
        if let existingWage = wages.first {
            return Int(existingWage.wage) ?? 1000
        }
        return 1000
    }

    private var calendar: Calendar {
        var calendar = Calendar.current
        calendar.firstWeekday = 2
        return calendar
    }

    private var startOfToday: Date {
        calendar.startOfDay(for: Date())
    }

    private var startOfTomorrow: Date {
        calendar.date(byAdding: .day, value: 1, to: startOfToday) ?? startOfToday
    }

    private var startOfWeek: Date {
        calendar.dateInterval(of: .weekOfYear, for: Date())?.start ?? Date()
    }

    private var endOfWeek: Date {
        calendar.date(byAdding: .day, value: 6, to: startOfWeek) ?? startOfWeek
    }

    private var startOfMonth: Date {
        calendar.dateInterval(of: .month, for: Date())?.start ?? Date()
    }

    private var endOfMonth: Date {
        if let startOfNextMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth) {
            return calendar.date(byAdding: .second, value: -1, to: startOfNextMonth) ?? startOfMonth
        }
        return Date()
    }

    private var startOfLastWeek: Date {
        calendar.date(byAdding: .day, value: -7, to: startOfWeek) ?? startOfWeek
    }

    private var endOfLastWeek: Date {
        calendar.date(byAdding: .day, value: -1, to: startOfWeek) ?? startOfWeek
    }

    private var startOfLastMonth: Date {
        let lastMonth = calendar.date(byAdding: .second, value: -1, to: startOfMonth) ?? startOfMonth
        return calendar.dateInterval(of: .month, for: lastMonth)?.start ?? lastMonth
    }

    private var endOfLastMonth: Date {
        calendar.date(byAdding: .second, value: -1, to: startOfMonth) ?? startOfMonth
    }

    @Query private var allRecords: [Record]

    private var todayRecords: [Record] {
        allRecords.filter { $0.startDate >= startOfToday && $0.startDate < startOfTomorrow }
    }

    private var weeklyRecords: [Record] {
        allRecords.filter { $0.startDate >= startOfWeek && $0.startDate < endOfWeek }
    }

    private var monthlyRecords: [Record] {
        allRecords.filter { $0.startDate >= startOfMonth && $0.startDate < endOfMonth }
    }

    private var lastWeeklyRecords: [Record] {
        allRecords.filter { $0.startDate >= startOfLastWeek && $0.startDate < endOfLastWeek }
    }

    private var lastMonthlyRecords: [Record] {
        allRecords.filter { $0.startDate >= startOfLastMonth && $0.startDate < endOfLastMonth }
    }

    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea()
            VStack {
                HeaderView(title: "マイナス時給")
                
                ScrollView {
                    SummaryView(
                        todayRecords: todayRecords, 
                        weeklyRecords: weeklyRecords, 
                        monthlyRecords: monthlyRecords,
                        lastWeeklyRecords: lastMonthlyRecords,
                        lastMonthlyRecords: lastMonthlyRecords,
                        wage: wage
                    )
                        .padding(.horizontal, 16)

                    TodaysAppsView(todayRecords: todayRecords, wage: wage)
                        .padding(.horizontal, 16)
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
