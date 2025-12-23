//
//  SettingsListView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 21/12/2025.
//

import SwiftUI
import SwiftData

struct SettingsListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var themes: [Theme]
    @Query private var languages: [Language]
    @Query private var currencies: [Currency]

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
                    Picker("", selection: currencyBinding) {
                        Text("日本円").tag("jpy")
                        Text("米ドル").tag("usd")
                        Text("ユーロ").tag("eur")
                        Text("英国ポンド").tag("gbp")
                        Text("オーストラリアドル").tag("aud")
                        Text("カナダドル").tag("cad")
                        Text("スイスフラン").tag("chf")
                    }
                    .pickerStyle(.menu)
                    .tint(Color.rgbo(red: 179, green: 179, blue: 179, opacity: 1))
                    .fontWeight(.light)
                }
                HStack {
                    HStack {
                        Image(systemName: "globe")
                        Text("言語")
                    }
                    Spacer()
                    Picker("", selection: languageBinding) {
                        Text("英語").tag("english")
                        Text("日本語").tag("japanese")
                    }
                    .pickerStyle(.menu)
                    .tint(Color.rgbo(red: 179, green: 179, blue: 179, opacity: 1))
                    .fontWeight(.light)
                }
                HStack {
                    HStack {
                        Image(systemName: "circle.righthalf.filled")
                        Text("外観モード")
                    }
                    Spacer()
                    Picker("", selection: themeBinding) {
                        Text("自動").tag("system")
                        Text("ライト").tag("light")
                        Text("ダーク").tag("dark")
                    }
                    .pickerStyle(.menu)
                    .tint(Color.rgbo(red: 179, green: 179, blue: 179, opacity: 1))
                    .fontWeight(.light)
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

extension SettingsListView {
    var themeBinding: Binding<String> {
        let theme = themes.first

        return Binding(
            get: { theme?.theme ?? "dark" },
            set: { newValue in
                if let existingTheme = theme {
                    existingTheme.theme = newValue
                } else {
                    modelContext.insert(Theme(theme: newValue))
                }
                try? modelContext.save()
            }
        )
    }
    var languageBinding: Binding<String> {
        let language = languages.first

        return Binding(
            get: { language?.language ?? "japanese" },
            set: { newValue in
                if let existingLanguage = language {
                    existingLanguage.language = newValue
                } else {
                    modelContext.insert(Language(language: newValue))
                }
                try? modelContext.save()
            }
        )
    }
    var currencyBinding: Binding<String> {
        let currency = currencies.first

        return Binding(
            get: { currency?.currency ?? "jpy" },
            set: { newValue in
                if let existingCurrency = currency {
                    existingCurrency.currency = newValue
                } else {
                    modelContext.insert(Currency(currency: newValue))
                }
                try? modelContext.save()
            }
        )
    }
}

#Preview {
    SettingsListView()
        .modelContainer(for: [Theme.self, Language.self, Currency.self], inMemory: true)
}
