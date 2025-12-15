//
//  ContentView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 15/12/2025.
//

import SwiftUI

let backgroundGradient = LinearGradient(
    colors: [Color.rgb(red: 1, green: 53, blue: 150), Color.black],
    startPoint: .top, endPoint: .bottom)

struct HomeView: View {
    var body: some View {
        ZStack {
            backgroundGradient
            VStack {
                SummaryView()
                    .padding(.horizontal, 16)
                    .frame(
                        minHeight: 100,
                        maxHeight: 350)
                TodaysAppsView()
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    HomeView()
}
