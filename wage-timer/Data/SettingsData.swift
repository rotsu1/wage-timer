//
//  SettingsData.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 22/12/2025.
//

import Foundation
import SwiftData

@Model
class Theme {
    var theme: String
    
    init(theme: String) {
        self.theme = theme
    }
}

@Model
class Language {
    var language: String

    init(language: String) {
        self.language = language
    }
}

@Model
class Currency {
    var currency: String

    init(currency: String) {
        self.currency = currency
    }
}

@Model
class Wage {
    var wage: String

    init(wage: String) {
        self.wage = wage
    }
}

@Model
class NotificationSettings {
    var weekly: Bool
    var dayOfWeek: String
    var weeklyTime: Date
    var monthly: Bool
    var monthlyTime: Date
    var alert: Date

    init(
        weekly: Bool, 
        dayOfWeek: String, 
        weeklyTime: Date,
        monthly: Bool,
        monthlyTime: Date,
        alert: Date
    ) {
        self.weekly = weekly
        self.dayOfWeek = dayOfWeek
        self.weeklyTime = weeklyTime
        self.monthly = monthly
        self.monthlyTime = monthlyTime
        self.alert = alert
    }
}