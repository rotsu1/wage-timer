//
//  NotificationSettingsView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 21/12/2025.
//
import SwiftUI
import SwiftData

struct NotificationSettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var notifications: [NotificationSettings]

    let dayOfWeek = [
        ("月曜日", "mon"), 
        ("火曜日", "tue"), 
        ("水曜日", "wed"), 
        ("木曜日", "thu"), 
        ("金曜日", "fri"), 
        ("土曜日", "sat"), 
        ("日曜日", "sun")
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundGradient
                    .ignoresSafeArea()
                VStack {                  
                    Form {
                        Section(
                            header: Text("レポート"),
                            footer: Text("過去7日間の収支レポートを毎週決まった日時に通知します。")
                        ) {
                            Toggle("週間レポート", isOn: weeklyToggleBinding)

                            pickerRow(image: "", title: "曜日", values: dayOfWeek, bind: dayOfWeekBinding)

                            DatePicker("時刻", selection: weeklyTimeBinding, displayedComponents: .hourAndMinute)
                                .environment(\.locale, Locale(identifier: "en_DK"))
                                .colorScheme(.dark)
                        }
                        .listRowBackground(Color.rgbo(red: 64, green: 64, blue: 64, opacity: 1))
                        
                        Section(
                            footer: Text("一ヶ月の収支レポートを月末の指定した時刻に通知します。")
                        ) {
                            Toggle("月間レポート", isOn: monthlyToggleBinding)

                            DatePicker("時刻", selection: monthlyTimeBinding, displayedComponents: .hourAndMinute)
                                .environment(\.locale, Locale(identifier: "en_DK"))
                                .colorScheme(.dark)     
                        }
                        .listRowBackground(Color.rgbo(red: 64, green: 64, blue: 64, opacity: 1))

                        Section(
                            header: Text("アラート"),
                            footer: Text("今日のアプリの使用時間が設定した時間を上回ると通知します。")
                        ) {
                            DatePicker("使用時間", selection: alertBinding, displayedComponents: .hourAndMinute)
                                .environment(\.locale, Locale(identifier: "en_DK"))
                                .colorScheme(.dark)
                        }
                        .listRowBackground(Color.rgbo(red: 64, green: 64, blue: 64, opacity: 1))
                    }
                    .scrollContentBackground(.hidden)

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
    }
}

extension NotificationSettingsView {
    var weeklyToggleBinding: Binding<Bool> {
        let notification = notifications.first

        return Binding(
            get: { notification?.weekly ?? true },
            set: { newValue in
                if let existingWeekly = notification {
                    existingWeekly.weekly = newValue
                } else {
                    addNotification()
                }
                try? modelContext.save()
            }
        )
    }
    var dayOfWeekBinding: Binding<String> {
        let notification = notifications.first

        return Binding(
            get: { notification?.dayOfWeek ?? "sun" },
            set: { newValue in
                if let existingDayOfWeek = notification {
                    existingDayOfWeek.dayOfWeek = newValue
                } else {
                    addNotification()
                }
                try? modelContext.save()
            }
        )
    }
    var weeklyTimeBinding: Binding<Date> {
        let notification = notifications.first

        return Binding(
            get: { 
                notification?.weeklyTime ?? 
                Calendar.current.date(from: DateComponents(hour: 20, minute: 0))! 
            },
            set: { newValue in
                if let existingWeeklyTime = notification {
                    existingWeeklyTime.weeklyTime = newValue
                } else {
                    addNotification()
                }
                try? modelContext.save()
            }
        )
    }
    var monthlyToggleBinding: Binding<Bool> {
        let notification = notifications.first

        return Binding(
            get: { notification?.monthly ?? true },
            set: { newValue in
                if let existingMonthly = notification {
                    existingMonthly.monthly = newValue
                } else {
                    addNotification()
                }
                try? modelContext.save()
            }
        )
    }
    var monthlyTimeBinding: Binding<Date> {
        let notification = notifications.first

        return Binding(
            get: { 
                notification?.monthlyTime ?? 
                Calendar.current.date(from: DateComponents(hour: 20, minute: 0))! 
            },
            set: { newValue in
                if let existingMonthlyTime = notification {
                    existingMonthlyTime.monthlyTime = newValue
                } else {
                    addNotification()
                }
                try? modelContext.save()
            }
        )
    }
    var alertBinding: Binding<Date> {
        let notification = notifications.first

        return Binding(
            get: { 
                notification?.alert ?? Calendar.current.date(from: DateComponents(hour: 1, minute: 0))! 
            },
            set: { newValue in
                if let existingAlert = notification {
                    existingAlert.alert = newValue
                } else {
                    addNotification()
                }
                try? modelContext.save()
            }
        )
    }

    func addNotification() {
        modelContext.insert(
            NotificationSettings(
                weekly: true, 
                dayOfWeek: "sun", 
                weeklyTime: Calendar.current.date(from: DateComponents(hour: 20, minute: 0))! ,
                monthly: true,
                monthlyTime: Calendar.current.date(from: DateComponents(hour: 20, minute: 0))!,
                alert: Calendar.current.date(from: DateComponents(hour: 2, minute: 0))! 
            )
        )
    }
}

#Preview {
    NotificationSettingsView()
}
