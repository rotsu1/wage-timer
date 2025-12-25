//
//  AddInputView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 21/12/2025.
//
import SwiftUI
import SwiftData

struct AddInputView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    var record: Record?

    @State private var dateString: String = ""
    @State private var date: Date
    @State private var appName: String
    @State private var time: String
    @FocusState private var isFocused: Bool

    init(record: Record? = nil) {
        self.record = record

        _date = State(initialValue: record?.startDate ?? Date())
        _appName = State(initialValue: record?.name ?? "")
        _time = State(initialValue: record.map { String($0.time) } ?? "")
    }

    @State private var showWarning: Bool = false
    @State private var showSuccess: Bool = false

    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.locale = Locale(identifier: "en_US_POSIX") // ensures consistent parsing
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }

    var body: some View {
        VStack {
            HStack {
                Text(record == nil ? "新規" : "編集")
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            VStack {
                HStack {
                    Text("日付")
                    Spacer()
                }
                HStack {
                    TextField("", text: $dateString)
                        .focused($isFocused)
                        .onAppear {
                            dateString = formatter.string(from: date)
                        }
                        .onChange(of: isFocused) {
                            if !isFocused {
                                if let newDate = formatter.date(from: dateString) {
                                    date = newDate
                                    dateString = formatter.string(from: date)
                                } else {
                                    dateString = formatter.string(from: date)
                                }
                            }
                        }
                    Spacer()
                    ZStack(alignment: .trailing) {
                        Image(systemName: "calendar")
                        DatePicker(
                            "",
                            selection: datePickerBinding,
                            displayedComponents: [.date]
                        )
                        .colorMultiply(.clear)
                    }
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
            }
            .padding(.horizontal, 16)
            VStack {
                HStack {
                    Text("アプリ名")
                    Spacer()
                }
                TextField("例: インスタ", text: $appName)
                .keyboardType(.numberPad)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.3))
                )
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.2))
                )
            }
            .padding(.horizontal, 16)
            VStack {
                HStack {
                    Text("使用時間（分）")
                    Spacer()
                }
                TextField("例: 120", text: $time)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.3))
                )
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.2))
                )
            }
           .padding(.horizontal, 16)
            HStack {
                Button(action: save) {
                    Text(record == nil ? "保存" : "更新")
                        .frame(maxWidth: 100, minHeight: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.blue)
                        )
                }
                Spacer()
            }
            .padding()
        }
        .foregroundStyle(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.3))
        )
        .overlay(alignment: .top) {
            if showWarning {
                toast(text: "未入力の欄があります", color: .red)
            }
        }
        .overlay(alignment: .top) {
            if showSuccess && record == nil {
                toast(
                    text: record == nil
                        ? "新しい記録が保存されました"
                        : "記録を更新しました",
                    color: .green
                )
            }
        }
        .animation(.easeInOut, value: showWarning)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.1))
        )
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.1))
        )
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("編集")
                    .foregroundColor(.white)
            }
        }
    }
}

extension AddInputView {
    var datePickerBinding: Binding<Date> {
        return Binding(
            get: { date },
            set: { newValue in
                date = newValue
                dateString = formatter.string(from: newValue)
            }
        )
    }

    func save() -> Void {
        if appName.isEmpty || time.isEmpty {
            showWarning = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                showWarning = false
            }
            return
        } else {
            let timeInt = Int(time) ?? 0
            if let record {
                record.name = appName
                record.startDate = date
                record.time = timeInt

                dismiss()
            } else {
                modelContext.insert(
                    Record(name: appName, startDate: date, time: timeInt)
                )
            }
            appName = ""
            time = ""
            showSuccess = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                showSuccess = false
            }
        }
    }

    func toast(text: String, color: Color) -> some View {
        Text(text)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(color.opacity(0.9))
            )
            .foregroundColor(.white)
            .padding(.top, 16)
            .transition(.move(edge: .top).combined(with: .opacity))
    }
}

//#Preview {
//    AddInputView()
//}
