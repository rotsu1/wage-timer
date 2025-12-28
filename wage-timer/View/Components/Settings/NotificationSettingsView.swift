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
        (String(localized: "Sunday"), 1),
        (String(localized: "Monday"), 2), 
        (String(localized: "Tuesday"), 3), 
        (String(localized: "Wednesday"), 4), 
        (String(localized: "Thursday"), 5), 
        (String(localized: "Friday"), 6), 
        (String(localized: "Saturday"), 7)
    ]

    var filter: RecordFilter { RecordFilter(records: records, currentDate: Date()) }

    private func onSettingsChange(_ id: String) -> Void {
        let calendar = Calendar.current
        var component = calendar.dateComponents(
            [.hour, .minute], 
            from: id == "Weekly Report" ? weeklyTime : monthlyTime
        )
        if id == "Weekly Report" {
            component.weekday = dayOfWeek
        }
        let totalTime = id == "Weekly Report" 
            ? filter.thisWeek.reduce(0) { $0 + $1.time }
            : filter.thisMonth.reduce(0) { $0 + $1.time }
        
        notification.scheduleNotifications(
            id: "Weekly Report",
            earnings: timeWageToDoubleLoss(time: totalTime, wage: wage),
            time: timeToString(time: totalTime),
            components: component
        )
    }

    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea()
            
            VStack {  
                if permissionGranted {
                    Form {
                        Section(
                            header: Text("Report"),
                            footer: Text("We will send a weekly notification of the past 7 days’ profit and loss report at a fixed time.")
                        ) {
                            Toggle("Weekly Report", isOn: $isWeekly)
                                .onChange(of: isWeekly) { _, newValue in
                                    Task {
                                        let isGranted = await notification.isPermitted()

                                        if newValue {
                                            if isGranted {
                                                onSettingsChange("Weekly Report")
                                            } else {
                                                notification.requestNotificationRequest()
                                                
                                                // Re-check permission after request
                                                let granted = await notification.isPermitted()
                                                if granted {
                                                    onSettingsChange("Weekly Report")
                                                    permissionGranted = true
                                                } else {
                                                    isWeekly = false
                                                }
                                            }
                                        } else {
                                            notification.deleteNotification("Weekly Report")
                                        }
                                    }
                                }

                            if isWeekly {
                                pickerRow(image: "", title: "Day of Week", values: dayOfWeekArray, bind: $dayOfWeek)
                                    .onChange(of: dayOfWeek) {
                                        onSettingsChange("Weekly Report")
                                    }

                                DatePicker(String(localized: "Time"), selection: $weeklyTime, displayedComponents: .hourAndMinute)
                                    .environment(\.locale, Locale(identifier: "en_DK"))
                                    .colorScheme(.dark)
                                    .onChange(of: weeklyTime) {
                                        onSettingsChange("Weekly Report")
                                    }
                            }
                        }
                        .listRowBackground(Color.rgbo(red: 64, green: 64, blue: 64, opacity: 1))
                        
                        Section(
                            footer: Text("We will send a monthly notification of your profit and loss report at a specified time on the last day of the month.")
                        ) {
                            Toggle("Monthly Report", isOn: $isMonthly)
                                .onChange(of: isMonthly) { _, newValue in
                                    Task {
                                        let isGranted = await notification.isPermitted()

                                        if newValue {
                                            if isGranted {
                                                onSettingsChange("Monthly Report")
                                            } else {
                                                notification.requestNotificationRequest()
                                                
                                                // Re-check permission after request
                                                let granted = await notification.isPermitted()
                                                if granted {
                                                    onSettingsChange("Monthly Report")
                                                    permissionGranted = true
                                                } else {
                                                    isMonthly = false
                                                }
                                            }
                                        } else {
                                            notification.deleteNotification("Monthly Report")
                                        }
                                    }
                                }

                            if isMonthly {
                                DatePicker(String(localized: "Time"), selection: $monthlyTime, displayedComponents: .hourAndMinute)
                                    .environment(\.locale, Locale(identifier: "en_DK"))
                                    .colorScheme(.dark)
                                    .onChange(of: monthlyTime) {
                                        onSettingsChange("Monthly Report")
                                    }
                            } 
                        }
                        .listRowBackground(Color.rgbo(red: 64, green: 64, blue: 64, opacity: 1))
                    }
                    .scrollContentBackground(.hidden)
                } else {
                    Text("Notifications are turned off. Please enable them in Settings > Wage Timer > Notifications.")
                    .padding()
                }

                Spacer()
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Notifications")
                    .foregroundColor(.white)
            }
        }
        .onAppear {
            Task {
                let weeklyData = await notification.isPending("Weekly Report")
                let monthlyData = await notification.isPending("Monthly Report")
                
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
