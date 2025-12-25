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

    var filter: RecordFilter { RecordFilter(records: records, currentDate: currentDate) }

    var calendarHelper: CalendarHelper { CalendarHelper(currentDate: currentDate) }

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
        formatter.dateFormat = "yyyy年MM月"
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
                ForEach(1...numberOfCells, id: \.self) { day in
                    let acutualDay = day - calendarHelper.firstWeekday + 1
                    if day < calendarHelper.firstWeekday {
                        Text("")
                    } else if day > calendarHelper.numberOfDays.count + calendarHelper.firstWeekday - 1 {
                        Text("")
                    } else {
                        Button {
                            changeDay(acutualDay)
                        } label: {
                            let calendar = Calendar.current
                            if acutualDay == calendar.component(.day, from: currentDate) {
                                VStack {
                                    Spacer()
                                    Text("\(acutualDay)")
                                    Spacer()
                                    Text("")
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity, minHeight: 60)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.2))
                                )
                            } else {
                                VStack {
                                    Spacer()
                                    Text("\(acutualDay)")
                                    Spacer()
                                    Text("")
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity, minHeight: 60)
                            }
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
