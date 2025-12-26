//
//  NotificationSettingsView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 21/12/2025.
//
import SwiftUI
import SwiftData

func defaultTime(hour: Int = 20, minute: Int = 0, second: Int = 0) -> Date {
    var components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
    components.hour = hour
    components.minute = minute
    components.second = second
    return Calendar.current.date(from: components) ?? Date()
}

struct NotificationSettingsView: View {
    var records: [Record]
    @Query private var wages: [Wage]
    var wage: Int {
        if let existingWage = wages.first {
            return Int(existingWage.wage) ?? 1000
        }
        return 1000
    }
    let notification = NotificationSettings()
    @State private var permissionGranted: Bool = false
    @State private var isWeekly: Bool = false
    @State private var isMonthly: Bool = false
    @State private var dayOfWeek: Int = 1
    @State private var weeklyTime: Date = defaultTime()
    @State private var monthlyTime: Date = defaultTime()
    
    let dayOfWeekArray = [
        ("日曜日", 1),
        ("月曜日", 2), 
        ("火曜日", 3), 
        ("水曜日", 4), 
        ("木曜日", 5), 
        ("金曜日", 6), 
        ("土曜日", 7)
    ]

    var filter: RecordFilter { RecordFilter(records: records, currentDate: Date()) }

    private func onSettingsChange(_ id: String) -> Void {
        let calendar = Calendar.current
        var component = calendar.dateComponents(
            [.hour, .minute], 
            from: id == "週間レポート" ? weeklyTime : monthlyTime
        )
        if id == "週間レポート" {
            component.weekday = dayOfWeek
        }
        let totalTime = id == "週間レポート" 
            ? filter.thisWeek.reduce(0) { $0 + $1.time }
            : filter.thisMonth.reduce(0) { $0 + $1.time }
        
        notification.scheduleNotifications(
            id: "週間レポート",
            earnings: timeWageToDoubleLoss(time: totalTime, wage: wage),
            time: timeToString(time: totalTime),
            components: component
        )
    }

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundGradient
                    .ignoresSafeArea()
                VStack {  
                    if permissionGranted {
                        Form {
                            Section(
                                header: Text("レポート"),
                                footer: Text("過去7日間の収支レポートを毎週決まった日時に通知します。")
                            ) {
                                Toggle("週間レポート", isOn: $isWeekly)
                                    .onChange(of: isWeekly) { _, newValue in
                                        Task {
                                            let isGranted = await notification.isPermitted()

                                            if newValue {
                                                if isGranted {
                                                    onSettingsChange("週間レポート")
                                                } else {
                                                    notification.requestNotificationRequest()
                                                    
                                                    // Re-check permission after request
                                                    let granted = await notification.isPermitted()
                                                    if granted {
                                                        onSettingsChange("週間レポート")
                                                        permissionGranted = true
                                                    } else {
                                                        isWeekly = false
                                                    }
                                                }
                                            } else {
                                                notification.deleteNotification("週間レポート")
                                            }
                                        }
                                    }

                                if isWeekly {
                                    pickerRow(image: "", title: "曜日", values: dayOfWeekArray, bind: $dayOfWeek)
                                        .onChange(of: dayOfWeek) {
                                            onSettingsChange("週間レポート")
                                        }

                                    DatePicker("時刻", selection: $weeklyTime, displayedComponents: .hourAndMinute)
                                        .environment(\.locale, Locale(identifier: "en_DK"))
                                        .colorScheme(.dark)
                                        .onChange(of: weeklyTime) {
                                            onSettingsChange("週間レポート")
                                        }
                                }
                            }
                            .listRowBackground(Color.rgbo(red: 64, green: 64, blue: 64, opacity: 1))
                            
                            Section(
                                footer: Text("一ヶ月の収支レポートを月末の指定した時刻に通知します。")
                            ) {
                                Toggle("月間レポート", isOn: $isMonthly)
                                    .onChange(of: isMonthly) { _, newValue in
                                        Task {
                                            let isGranted = await notification.isPermitted()

                                            if newValue {
                                                if isGranted {
                                                    onSettingsChange("月間レポート")
                                                } else {
                                                    notification.requestNotificationRequest()
                                                    
                                                    // Re-check permission after request
                                                    let granted = await notification.isPermitted()
                                                    if granted {
                                                        onSettingsChange("月間レポート")
                                                        permissionGranted = true
                                                    } else {
                                                        isMonthly = false
                                                    }
                                                }
                                            } else {
                                                notification.deleteNotification("月間レポート")
                                            }
                                        }
                                    }

                                if isMonthly {
                                    DatePicker("時刻", selection: $monthlyTime, displayedComponents: .hourAndMinute)
                                        .environment(\.locale, Locale(identifier: "en_DK"))
                                        .colorScheme(.dark)
                                        .onChange(of: monthlyTime) {
                                            onSettingsChange("月間レポート")
                                        }
                                } 
                            }
                            .listRowBackground(Color.rgbo(red: 64, green: 64, blue: 64, opacity: 1))
                        }
                        .scrollContentBackground(.hidden)
                    } else {
                        Text("通知がオフになっています。設定 > [アプリ名] > 通知 から許可設定をお願いします。")
                        .padding()
                    }

                    Spacer()
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 16)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("通知")
                    .foregroundColor(.white)
            }
        }
        .onAppear {
            Task {
                let weeklyData = await notification.isPending("週間レポート")
                let monthlyData = await notification.isPending("月間レポート")
                
                isWeekly = weeklyData.isPending
                isMonthly = monthlyData.isPending
                dayOfWeek = weeklyData.components?.weekday ?? dayOfWeek

                let calendar = Calendar.current
                if let existingWeekly = weeklyData.components {
                    weeklyTime = calendar.date(from: existingWeekly) ?? weeklyTime
                }
                if let existingMonthly = monthlyData.components {
                    monthlyTime = calendar.date(from: existingMonthly) ?? monthlyTime
                }
            }
        }
        .task {
            permissionGranted = await notification.isPermitted()
        }
    }
}

#Preview {
    NotificationSettingsView(records: [])
}
