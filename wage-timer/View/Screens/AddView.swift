//
//  AddView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 21/12/2025.
//
import SwiftUI

struct AddView: View {
    var records: [Record]

    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea()

            VStack {
                HeaderView(title: "マイナス時給")

                AddInputView(records: records)
                    .padding(.horizontal, 16)
                
                Spacer()
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

//#Preview {
//    AddView()
//}
