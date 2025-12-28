//
//  PeriodView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 21/12/2025.
//
import SwiftUI
import SwiftData

struct PeriodView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var analysisDates: [Analysis]

    @State private var showModal = false

    func period(_ analysisDate: Analysis) -> some View {
        let year = analysisDate.year
        let month = analysisDate.month

        let period = month == 0 ? "\(String(year))" : "\(String(year))/\(month)"
        return Text(period)
    }

    var todayYear: Int {
        let today = Date()
        let calendar = Calendar.current
        return calendar.component(.year, from: today)
    }

    var body: some View {
        Button {
            showModal = true
        } label: {
            HStack {
                Text("Period")
                Spacer()
                if let analyis = analysisDates.first {
                    period(analyis)
                } else {
                    Text(String(todayYear))
                }
                Image(systemName: "chevron.right")
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
        .sheet(isPresented: $showModal) {
            PeriodModal()
        }
    }
}

#Preview {
    PeriodView()
}
