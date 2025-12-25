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
    @Query private var wage: [Wage]

    let languageDict = [
        ("英語", "english"),
        ("日本語", "japanese")
    ]
    let currecyDict = [
        ("日本円", "jpy"),
        ("米ドル", "usd"),
        ("ユーロ", "eur"),
        ("英国ポンド", "gbp"),
        ("オーストラリアドル", "aud"),
        ("カナダドル", "cad"),
        ("スイスフラン", "chf")
    ]
    let themeDict = [
        ("自動", "system"),
        ("ライト", "light"),
        ("ダーク", "dark")
    ]

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
                ZStack {
                    NavigationLink(destination: WageSettingsView()) {
                        EmptyView()
                    }
                    navRow(image: "yensign.arrow.trianglehead.counterclockwise.rotate.90", title: "時給", details: "¥\(wageDisplay(wage: wage))")                
                }

                ZStack {
                    NavigationLink(destination: NotificationSettingsView()) {
                        EmptyView()
                    }
                    navRow(image: "bell", title: "通知", details: "")
                }
                
                pickerRow(image: "yensign", title: "通貨", values: currecyDict, bind: currencyBinding)

                pickerRow(image: "globe", title: "言語", values: languageDict, bind: languageBinding)

                pickerRow(image: "circle.righthalf.filled", title: "外観モード", values: themeDict, bind: themeBinding)

            } header: {
                Text("アプリ")
                .foregroundStyle(.white)
            }
            .listRowBackground(Color.rgbo(red: 64, green: 64, blue: 64, opacity: 1))

            Section {
                ZStack {
                    NavigationLink(destination: NotificationSettingsView()) {
                        EmptyView()
                    }
                    navRow(image: "questionmark", title: "ヘルプ・使い方", details: "")
                }
            }
            .listRowBackground(Color.rgbo(red: 64, green: 64, blue: 64, opacity: 1))
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
            }
        )
    }

    private func wageDisplay(wage: [Wage]) -> String {
        let wage = wage.first
        if let existingWage = wage {
            return existingWage.wage
        } else {
            return "1000"
        }
    }
}

func navRow(image: String, title: String, details: String) -> some View {
    HStack {
        HStack {
            Image(systemName: image)
            Text(title)
        }
        .foregroundStyle(.white)
        Spacer()
        HStack {
            Text(details)
            Image(systemName: "chevron.right")
        }
        .fontWeight(.light)
        .foregroundStyle(Color.rgbo(red: 179, green: 179, blue: 179, opacity: 1))
    }
}

#Preview {
    SettingsListView()
        .modelContainer(for: [Theme.self, Language.self, Currency.self, Wage.self], inMemory: true)
}
