//
//  CalendarView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 18/12/2025.
//

import SwiftUI

func card(title: String, time: String, occurance: String? = nil, money: String) -> some View {
    let description = occurance != nil 
        ? "総使用時間: \(time) 使用回数: \(occurance ?? "0")"
        : "使用時間: \(time)"
    return(
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .fontWeight(.bold)
                Text(description)
                .font(.subheadline)
                .fontWeight(.thin)
            }
            Spacer()
            VStack {
                Text(money)
            }
            .padding(.all, 8)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.3))
            )
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.3))
                )
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.3))
        )
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.2))
            )
    )
}
