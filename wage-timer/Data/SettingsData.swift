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