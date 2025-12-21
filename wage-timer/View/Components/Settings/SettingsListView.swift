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
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.rgbo(red: 146, green: 144, blue: 202, opacity: 1), 
                                    Color.rgbo(red: 85, green: 84, blue: 117, opacity: 1)
                                ],
                                startPoint: .top, endPoint: .bottom
                            )
                        )
                )
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            Section {
                HStack {
                    HStack {
                        Image(systemName: "yensign.arrow.trianglehead.counterclockwise.rotate.90")
                        Text("時給")
                    }
                    Spacer()
                    HStack {
                        Text("¥1000")
                        Image(systemName: "chevron.right")
                    }
                    .fontWeight(.light)
                    .foregroundStyle(Color.rgbo(red: 179, green: 179, blue: 179, opacity: 1))
                }
                HStack {
                    HStack {
                        Image(systemName: "yensign")
                        Text("通貨")
                    }
                    Spacer()
                    HStack {
                        Text("日本円")
                        Image(systemName: "chevron.right")
                    }
                    .fontWeight(.light)
                    .foregroundStyle(Color.rgbo(red: 179, green: 179, blue: 179, opacity: 1))
                }
                HStack {
                    HStack {
                        Image(systemName: "globe")
                        Text("言語")
                    }
                    Spacer()
                    HStack {
                        Text("日本語")
                        Image(systemName: "chevron.right")
                    }
                    .fontWeight(.light)
                    .foregroundStyle(Color.rgbo(red: 179, green: 179, blue: 179, opacity: 1))
                }
                HStack {
                    HStack {
                        Image(systemName: "circle.righthalf.filled")
                        Text("外観モード")
                    }
                    Spacer()
                    HStack {
                        Text("ダーク")
                        Image(systemName: "chevron.up.chevron.down")
                    }
                    .fontWeight(.light)
                    .foregroundStyle(Color.rgbo(red: 179, green: 179, blue: 179, opacity: 1))
                }
                HStack {
                    HStack {
                        Image(systemName: "bell")
                        Text("通知")
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .fontWeight(.light)
                        .foregroundStyle(Color.rgbo(red: 179, green: 179, blue: 179, opacity: 1))
                }
            } header: {
                Text("アプリ")
                .foregroundStyle(.white)
            }
            .listRowBackground(Color.rgbo(red: 64, green: 64, blue: 64, opacity: 1))
            .foregroundStyle(.white)

            Section {
                HStack {
                    HStack {
                        Image(systemName: "questionmark")
                        Text("ヘルプ・使い方")
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .fontWeight(.light)
                        .foregroundStyle(Color.rgbo(red: 179, green: 179, blue: 179, opacity: 1))
                }
            }
            .listRowBackground(Color.rgbo(red: 64, green: 64, blue: 64, opacity: 1))
            .foregroundStyle(.white)

        }
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    SettingsListView()
}
