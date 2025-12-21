//
//  AnalysisView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 21/12/2025.
//

import SwiftUI

struct AnalysisView: View {
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

                PeriodView()
                    .padding(.horizontal, 16)
                GraphView()
                    .padding(.horizontal, 16)
                CategoryView()
                    .padding(.horizontal, 16)
                
                Spacer()
            }
        }
    }
}

#Preview {
    AnalysisView()
}
