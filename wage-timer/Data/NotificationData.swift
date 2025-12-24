//
//  NotificationData.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 24/12/2025.
//
import SwiftUI
import SwiftData

@Model
class Notification {
    var title: String
    var image: String
    var context: String
    var date: Date
    
    init(title: String, image: String, context: String, date: Date) {
        self.title = title
        self.image = image
        self.context = context
        self.date = date
    }
}
