//
//  CategoryView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 21/12/2025.
//

import SwiftUI

struct CategoryView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Category")
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
            }
            HStack {
                Text("2025")
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
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.3))
        )
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.1))
        )
        .foregroundStyle(Color.white)
    }
}

#Preview {
    CategoryView()
}