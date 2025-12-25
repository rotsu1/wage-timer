//
//  Time.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 24/12/2025.
//
import SwiftUI
import SwiftData
import Foundation

func timeToString(time: Int) -> String {
    let days = time / 1440
    let hours = time % 1440 / 60
    let minutes = time % 60
    let components = [
        days > 0 ? "\(days)d" : nil,
        hours > 0 ? "\(hours)h" : nil,
        minutes > 0 ? "\(minutes)m" : nil
    ].compactMap { $0 } 

    let result = components.joined(separator: " ")

    return result.isEmpty ? "0m" : result
}

func lossToString(time: Int, wage: Int) -> String {
    let hours = roundToX(Double(time), point: 2)
    let loss = hours * Double(wage)
    return loss == 0 ? "¥0" : "-¥\(loss)"
}

func roundToX(_ value: Double, point: Int) -> Double {
    let multiplier = pow(10.0, Double(point))
    return (value * multiplier).rounded() / multiplier
}

struct RecordSummary: Identifiable {
    let id = UUID()
    let name: String
    let totalTime: Int
    let occurance: Int
}

func groupRecordsByName(records: [Record]) -> [RecordSummary] {
    let grouped = Dictionary(grouping: records, by: { $0.name })
    
    return grouped.map { (name, records) in
        RecordSummary(
            name: name,
            totalTime: records.reduce(0) { $0 + $1.time },
            occurance: records.count
        )
    }
}

func groupRecordsByDay(records: [Record]) -> [RecordSummary] {
    let calendar = Calendar.current
    let grouped = Dictionary(grouping: records, by: { record in
        calendar.startOfDay(for: record.startDate)
    })
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd"
    
    return grouped.map { (date, records) in
        RecordSummary(
            name: formatter.string(from: date),
            totalTime: records.reduce(0) { $0 + $1.time },
            occurance: records.count
        )
    }
}
