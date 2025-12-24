//
//  Time.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 24/12/2025.
//

func toTime(time: Int) -> String {
    let days = time / 1440
    let hours = time % 1440 / 60
    let minutes = time % 60
    let components = [
        days > 0 ? "\(days)d" : nil,
        hours > 0 ? "\(hours)h" : nil,
        minutes > 0 ? "\(minutes)m" : nil
    ].compactMap { $0 } 

    let result = components.joined(separator: " ")

    return result
}

func lossToString(time: Int, wage: Int) -> String {
    let hours = ((Double(time) / 60) * 100).rounded() / 100 
    let loss = hours * Double(wage)
    return "-¥\(loss)"
}