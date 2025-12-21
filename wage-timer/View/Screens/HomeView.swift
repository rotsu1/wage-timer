//
//  HomeView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 18/12/2025.
//
import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea()
            VStack {
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
                ScrollView {
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
}

#Preview {
    HomeView()
}
