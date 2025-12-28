//
//  HomeView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 18/12/2025.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    var records: [Record]
    var filter: RecordFilter { RecordFilter(records: records, currentDate: Date()) }

    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea()

            VStack {
                HeaderView(title: "Home")
                
                ScrollView {
                    SummaryView(
                        todayRecords: filter.today, 
                        weeklyRecords: filter.thisWeek, 
                        monthlyRecords: filter.thisMonth,
                        lastWeeklyRecords: filter.lastWeek,
                        lastMonthlyRecords: filter.lastMonth,
                    )
                        .padding(.horizontal, 16)

                    TodaysAppsView(todayRecords: filter.today)
                        .padding(.horizontal, 16)
                    
                    Spacer()
                }
            }
        }
    }
}

//#Preview {
//    HomeView()
//}
