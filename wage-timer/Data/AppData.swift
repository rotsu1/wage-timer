//
//  AppDataView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 24/12/2025.
//
import SwiftUI
import SwiftData

@Model
class Record {
    var name: String
    var startDate: Date
    var time: Int

    init(name: String, startDate: Date, time: Int) {
        self.name = name
        self.startDate = startDate
        self.time = time
    }
}
