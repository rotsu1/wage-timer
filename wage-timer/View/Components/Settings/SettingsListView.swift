//
//  Settings.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 21/12/2025.
//

import SwiftUI

struct SettingsListView: View {
    var body: some View {
        Form {
            Section {
                HStack {
                    Spacer()
                    Image(systemName: "trophy.fill")
                        .foregroundStyle(Color.rgbo(red: 235, green: 235, blue: 48, opacity: 1))
                    Text("プレミアム")
                        .foregroundStyle(.white)
                    Spacer()
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.rgbo(red: 128, green: 110, blue: 110, opacity: 0.8))
                )
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            Section {
                HStack {
                    Text("時給")
                    Spacer()
                    HStack {
                        Text("¥1000")
                        Image(systemName: "chevron.right")
                    }
                }
                HStack {
                    Text("通貨")
                    Spacer()
                    HStack {
                        Text("日本円")
                        Image(systemName: "chevron.right")
                    }
                }
                HStack {
                    Text("言語")
                    Spacer()
                    HStack {
                        Text("日本語")
                        Image(systemName: "chevron.right")
                    }
                }
                HStack {
                    Text("外観モード")
                    Spacer()
                    HStack {
                        Text("ダーク")
                        Image(systemName: "chevron.up.chevron.down")
                    }
                }
                HStack {
                    Text("通知")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            } header: {
                Text("アプリ")
                .foregroundStyle(.white)
            }
            .listRowBackground(Color.rgbo(red: 128, green: 110, blue: 110, opacity: 1))
            .foregroundStyle(.white)

            Section {
                HStack {
                    HStack {
                        Image(systemName: "questionmark")
                        Text("ヘルプ・使い方")
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            }
            .listRowBackground(Color.rgbo(red: 128, green: 110, blue: 110, opacity: 1))
            .foregroundStyle(.white)

        }
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    SettingsListView()
}
