//
//  Calendar.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 18/12/2025.
//
import SwiftUI

struct CalendarView: View {
    @State private var date: Date = Date()

    var records: [Record]

    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea()
                .onTapGesture {
                    hideKeyboard()
                }
                
            VStack {
                HeaderView(title: "Calendar")

                ScrollView {                
                    CalendarComponentView(currentDate: $date, records: records)
                        .padding(.horizontal, 16)
                    CalendarDaySummaryView(currentDate: $date, records: records)
                        .padding(.horizontal, 16)
                    
                    Spacer()
                }
            }
        }
    }
}

//#Preview {
//    CalendarView()
//}
