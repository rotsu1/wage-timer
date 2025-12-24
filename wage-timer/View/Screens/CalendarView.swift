//
//  Calendar.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 18/12/2025.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea()
            VStack {
                HeaderView(title: "カレンダー")

                ScrollView {                
                    CalendarComponentView()
                        .padding(.horizontal, 16)
                    CalendarDaySummaryView()
                        .padding(.horizontal, 16)
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    CalendarView()
}
