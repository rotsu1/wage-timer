//
//  WageSettingsView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 23/12/2025.
//
import SwiftUI
import SwiftData

struct WageSettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var wages: [Wage]
    @State private var newWage: String = ""

    @FocusState private var isWageFocused: Bool

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundGradient
                    .ignoresSafeArea()
                VStack {                  
                    VStack {
                        HStack {
                            Text("時給")
                            Spacer()
                        }
                        HStack {
                            Text("¥")
                            TextField("", text: Binding(
                                get: { wages.first?.wage ?? "1000" },
                                set: { newValue in
                                    if let existingWage = wages.first {
                                        existingWage.wage = newValue
                                    } else {
                                        let new = Wage(wage: newValue)
                                        modelContext.insert(new)
                                    }
                                }
                            ))
                            .keyboardType(.numberPad)
                        }
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.3))
                        )
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.2))
                        )

                        Text("時間を有効活用できた時の時給を設定してみよう！")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.caption)
                        Text("例1: 現在のバイトの時給")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.caption)
                        Text("例2: 勉強に時間を投じたら将来的に時給3000円になる")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.caption)

                    }
                    .padding(.horizontal, 16)

                    Spacer()
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 16)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("時給設定")
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    WageSettingsView()
}
