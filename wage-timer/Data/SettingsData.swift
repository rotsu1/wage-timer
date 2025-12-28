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
class Analysis {
    var year: Int
    var month: Int

    init(year: Int, month: Int) {
        self.year = year
        self.month = month
    }
}