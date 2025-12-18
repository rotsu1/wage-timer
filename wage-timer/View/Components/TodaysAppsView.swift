//
//  TodaysAppsView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 15/12/2025.
//

import SwiftUI

func card(title: String, time: String, occurance: String, money: String) -> some View {
    HStack {
        VStack(alignment: .leading) {
            Text(title)
                .fontWeight(.bold)
            Text("総使用時間: \(time) 使用回数: \(occurance)")
                .font(.subheadline)
                .fontWeight(.thin)
        }
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
}

struct TodaysAppsView: View {
    var body: some View {
        VStack() {
            HStack {
                Text("今日使ったアプリ")
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
            }
            card(title: "YouTube", time: "6h 20m", occurance: "9", money: "-¥1000")
            card(title: "Instagram", time: "6h 20m", occurance: "9", money: "-¥1000")
            card(title: "X", time: "6h 20m", occurance: "9", money: "-¥1000")
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.3))
        )
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.1))
        )
        .foregroundStyle(.white)
    }
}

#Preview {
    TodaysAppsView()
}
