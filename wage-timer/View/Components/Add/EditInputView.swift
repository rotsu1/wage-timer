//
//  EditInputView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 25/12/2025.
//
import SwiftUI
import SwiftData

struct EditInputView: View {
    var record: Record

    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea()
            VStack {
                ScrollView {                
                    AddInputView(record: record)
                        .padding()
                    
                    Spacer()
                }
            }
        }
    }
}
