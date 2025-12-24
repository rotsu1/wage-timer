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
                HeaderView(title: "マイナス時給")
                
                ScrollView {
                    SummaryView()
                        .padding(.horizontal, 16)

                    TodaysAppsView()
                        .padding(.horizontal, 16)
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
