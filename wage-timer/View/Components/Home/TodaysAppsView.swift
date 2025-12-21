//
//  TodaysAppsView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 15/12/2025.
//

import SwiftUI

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
