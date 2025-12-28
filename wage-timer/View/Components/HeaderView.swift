//
//  HeaderView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 21/12/2025.
//
import SwiftUI
import SwiftData

struct HeaderView: View {
    var title: LocalizedStringKey

    var body: some View {
        HStack {
            VStack {
                Text("  ")
            }
            Spacer()
            Text(title)
                .foregroundStyle(.white)
            Spacer()
            NavigationLink(destination: NotificationView()) {
                Image(systemName: "bell")
                .foregroundStyle(.white)
            }
        }
        .padding()
    }
}
