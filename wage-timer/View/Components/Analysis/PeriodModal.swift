//
//  PeriodModal.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 21/12/2025.
//
import SwiftUI
import SwiftData

struct PeriodModal: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var analysisDates: [Analysis]
    @FocusState private var isFocused: Bool
    @State private var yearString = ""
    
    @Environment(\.dismiss) private var dismiss

    var todayYear: Int {
        let today = Date()
        let calendar = Calendar.current
        return calendar.component(.year, from: today)
    }

    var monthBinding: Binding<Int> {
        let analysisDate = analysisDates.first
        
        return Binding(
            get: { analysisDate?.month ?? 0 },
            set: { newValue in
                if let existingAnalysisDate = analysisDate {
                    existingAnalysisDate.month = newValue
                } else {
                    modelContext.insert(Analysis(year: todayYear, month: newValue))
                }
            }
        )
    }

    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text(" ")
                    Spacer()
                    Text("期間設定")
                    Spacer()
                    Button(action: {
                        dismiss() // closes the modal
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                HStack {
                    Text("年:")

                    Spacer()

                    TextField("例: 2025", text: $yearString)
                        .focused($isFocused)
                        .onAppear {
                            if let existingAnalysisDates = analysisDates.first {
                                yearString = String(existingAnalysisDates.year)
                            } else {
                                yearString = String(todayYear)
                            }
                        }
                        .onChange(of: isFocused) {
                            if !isFocused {
                                if yearString.isEmpty || Int(yearString)! <= 0 {
                                    if let existingAnalysisDates = analysisDates.first {
                                        yearString = String(existingAnalysisDates.year)
                                    } else {
                                        yearString = String(todayYear)
                                    }
                                    return
                                }
                                if let existingAnalysisDates = analysisDates.first {
                                    existingAnalysisDates.year = Int(yearString) ?? todayYear
                                } else {
                                    modelContext.insert(Analysis(year: todayYear, month: 0))
                                }
                            }
                        }
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 16)
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
                .padding(.horizontal, 16)
                
                let months = (0...12).map { 
                    let display = $0 == 0 ? "指定なし" : "\($0)月"
                    return (key: display, value: $0) 
                }
                pickerRow(
                    image: "", 
                    title: "月", 
                    values: months, 
                    bind: monthBinding,
                    color: .white)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.3))
                        
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.2))
                    )
                    .padding(.horizontal, 16)
                Spacer()
            }
            .foregroundStyle(Color.white)
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

#Preview {
    PeriodModal()
        .modelContainer(for: [Analysis.self], inMemory: true)
}
