//
//  HomeView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 18/12/2025.
//
import SwiftUI

let backgroundGradient = LinearGradient(
    colors: [Color.rgb(red: 1, green: 53, blue: 150), Color.black],
    startPoint: .top, endPoint: .bottom)

struct HomeView: View {
    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea()
            ScrollView {
                HStack {
                    VStack {
                        Text("  ")
                    }
                    Spacer()
                    Text("マイナス時給")
                        .foregroundStyle(.white)
                    Spacer()
                    Image(systemName: "bell")
                        .foregroundStyle(.white)
                }
                .padding()
                SummaryView()
                    .padding(.horizontal, 16)
                    .frame(
                        minHeight: 100,
                        maxHeight: 350)
                TodaysAppsView()
                    .padding([.top, .horizontal], 16)
                
                Spacer()
            }
        }
    }
}

#Preview {
    HomeView()
}
