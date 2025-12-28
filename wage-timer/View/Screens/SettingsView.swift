//
//  SettingsView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 21/12/2025.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    var records: [Record]
    
    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea()

            VStack {
                HeaderView(title: "Settings")
                
                SettingsListView(records: records)
            }
        }
    }
}

//#Preview {
//    SettingsView()
//        .modelContainer(for: [Theme.self, Language.self, Currency.self, Wage.self], inMemory: true)
//}
