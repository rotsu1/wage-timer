//
//  GraphView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 21/12/2025.
//

import SwiftUI

struct GraphView: View {
    var body: some View {
        VStack {
            HStack {
                Text("収支")
                Spacer()
            }
            HStack {
                Text("-¥400000")
                    .foregroundStyle(.red)
                Spacer()
            }
            ChartView()
                .frame(minHeight: 200, maxHeight: 500)
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
        .foregroundStyle(.white)
    }
}

#Preview {
    GraphView()
}
