//
//  SummaryView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 15/12/2025.
//
import SwiftUI
import SwiftData

private func card(title: String, money: String, description: String) -> some View {
    VStack(alignment: .leading) {
        Text(title)
        Spacer()
        Text(money)
            .fontWeight(.bold)
        Spacer()
        Text(description)
    }
    .lineLimit(1)
    .minimumScaleFactor(0.5)
    .frame(maxWidth: .infinity, minHeight: 80, alignment: .leading)
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

struct SummaryView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("今日のマイナス")
                    Text("-¥10000")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                }
                Spacer()
                VStack {
                    VStack {
                        Text("前週比 +432%")
                            .fontWeight(.bold)
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
                    VStack {
                        Text("前月比 +100%")
                            .fontWeight(.bold)
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
            }
            .padding(.bottom, 16)
            HStack(spacing: 16) {
                card(title: "今週", money: "-¥26583", description: "26.6h")
                card(title: "今月", money: "-¥35750", description: "35.8h")
            }
            HStack {
                card(title: "一番使ったアプリ", money: "Instagram", description: "12h 20m")
                card(title: "最高損失", money: "-¥10000", description: "2h 20m")
                card(title: "開いた回数", money: "9", description: "平均損失 ¥1000")
            }
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
    SummaryView()
}
