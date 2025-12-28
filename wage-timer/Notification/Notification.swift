//
//  Notification.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 26/12/2025.
//

import UserNotifications
import Foundation

class NotificationSettings {
    var center: UNUserNotificationCenter

    init() {
        self.center = UNUserNotificationCenter.current()
    }

    func requestNotificationRequest() -> Void {
        if !UserDefaults.standard.bool(forKey: "didRequestNotification") {
            self.center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Notification permission error:", error)
                        return
                    }

                    UserDefaults.standard.set(granted, forKey: "notificationEnabled")

                    if granted {
                        print("Notifications enabled")
                    } else {
                        print("Notifications denied")
                    }
                }
            }
            UserDefaults.standard.set(true, forKey: "didRequestNotification")
        }
    }

    func isPermitted() async -> Bool {
        let settings = await self.center.notificationSettings()
        switch settings.authorizationStatus {
        case .authorized, .provisional, .ephemeral:
            return true
        case .denied, .notDetermined:
            return false
        @unknown default:
            return false
        }
    }

    func isPending(_ id: String) async -> (
        isPending: Bool, 
        components: DateComponents?
    ) {
        let requests = await self.center.pendingNotificationRequests()
        let isPending = requests.contains { $0.identifier == id }
        var components: DateComponents? = nil
        for request in requests {
            if request.identifier == id {
                if let trigger = request.trigger as? UNCalendarNotificationTrigger {
                    components = trigger.dateComponents
                }
            }
        }
        return (isPending, components)
    }

    func scheduleNotifications(
        id: String,
        earnings: Double,
        time: String,
        components: DateComponents
    ) -> Void {

        self.deleteNotification(id)

        let content = UNMutableNotificationContent()
        content.title = id
        content.body = "Loss: \(earnings)\n Wasted Time: \(time)"
        content.sound = .default

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: components,
            repeats: true
        )

        let request = UNNotificationRequest(
            identifier: id,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }

    func deleteNotification(_ id: String) {
        self.center
            .removePendingNotificationRequests(
                withIdentifiers: [id]
            )
    }
}