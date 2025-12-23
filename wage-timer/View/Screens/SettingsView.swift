//
//  SettingsView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 21/12/2025.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
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
                
                SettingsListView()
            }
        }
    }
}

#Preview {
    SettingsView()
        .modelContainer(for: [Theme.self, Language.self, Currency.self, Wage.self], inMemory: true)
}
