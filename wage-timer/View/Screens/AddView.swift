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
            VStack {
                HeaderView(title: "マイナス時給")

                ScrollView {
                    AddInputView()
                        .padding(.horizontal, 16)
                }
            }
        }
    }
}

#Preview {
    AddView()
}
