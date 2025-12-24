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
            VStack {
                HeaderView(title: "分析")
                
                ScrollView {
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
}

#Preview {
    AnalysisView()
}
