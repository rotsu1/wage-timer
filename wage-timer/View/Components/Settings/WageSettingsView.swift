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
    @Query private var currencies: [Currency]
    var currency: String {
        if let existingCurrency = currencies.first {
            return existingCurrency.currency
        }
        return "¥"
    }

    @FocusState private var isWageFocused: Bool

    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea()

            VStack {                  
                VStack {
                    HStack {
                        Text("Wage")
                        Spacer()
                    }
                    HStack {
                        Text(currency)
                        TextField("", text: Binding(
                            get: { wages.first?.wage ?? "1000" },
                            set: { newValue in
                                guard let intValue = Int(newValue) else { return }
                                guard intValue > 0 else { return }
                                
                                if let existingWage = wages.first {
                                    existingWage.wage = String(intValue)
                                } else {
                                    let new = Wage(wage: String(intValue))
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

                    Text("Let’s set an hourly rate for when you use your time effectively")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.caption)
                    Text("Example 1: Your current part-time job hourly wage")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.caption)
                    Text("Example 2: If you invest time in studying, your future hourly rate could be ¥3,000.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.caption)

                }
                .padding(.horizontal, 16)

                Spacer()
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
        }
        
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Wage Settings")
                    .foregroundColor(.white)
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

#Preview {
    WageSettingsView()
}
