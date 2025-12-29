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
    @Query private var currencies: [Currency]
    var currency: String {
        if let existingCurrency = currencies.first {
            return existingCurrency.currency
        }
        return "¥"
    }
    @Query private var wage: [Wage]
    var records: [Record]

    @State private var showModal = false

    let currecyDict = [
        (String(localized: "JPY"), "¥"),
        (String(localized: "USD"), "$"),
        (String(localized: "EUR"), "€"),
        (String(localized: "GBP"), "£"),
    ]
    let themeDict = [
        (String(localized: "System"), "system"),
        (String(localized: "Light"), "light"),
        (String(localized: "Dark"), "dark")
    ]

    var body: some View {
        Form {
            Section {
                Button {
                    showModal = true
                } label: {
                    HStack {
                        Spacer()
                        Image(systemName: "trophy.fill")
                            .foregroundStyle(Color.rgbo(red: 235, green: 235, blue: 48, opacity: 1))
                        Text("Premium")
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    .padding()
                }
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
                .sheet(isPresented: $showModal) {
                    PremiumModal()
                }
            }
            Section {
                ZStack {
                    NavigationLink(destination: WageSettingsView()) {
                        EmptyView()
                    }
                    navRow(
                        image: "yensign.arrow.trianglehead.counterclockwise.rotate.90", 
                        title: "Hourly Wage", 
                        details: "\(currency)\(wageDisplay(wage: wage))"
                    )                
                }

                ZStack {
                    NavigationLink(destination: NotificationSettingsView(records: records)) {
                        EmptyView()
                    }
                    navRow(image: "bell", title: "Notifications", details: "")
                }
                
                pickerRow(image: "yensign", title: "Currency", values: currecyDict, bind: currencyBinding)

                // pickerRow(image: "circle.righthalf.filled", title: "Appearance", values: themeDict, bind: themeBinding)

            } header: {
                Text("Apps")
                .foregroundStyle(.white)
            }
            .listRowBackground(Color.rgbo(red: 64, green: 64, blue: 64, opacity: 1))

            Section {
                ZStack {
                    NavigationLink(destination: HelpView()) {
                        EmptyView()
                    }
                    navRow(image: "questionmark", title: "Help & Usage", details: "")
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
    var currencyBinding: Binding<String> {
        let currency = currencies.first

        return Binding(
            get: { currency?.currency ?? "¥" },
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

func navRow(image: String, title: LocalizedStringKey, details: String) -> some View {
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