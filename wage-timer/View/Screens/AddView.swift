//
//  AddView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 21/12/2025.
//
import SwiftUI

struct AddView: View {
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
                AddInputView()
            }
        }
    }
}

#Preview {
    AddView()
}
