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
    
    var records: [Record]
    var record: Record?
    @Query private var wages: [Wage]
    var wage: Int {
        if let existingWage = wages.first {
            return Int(existingWage.wage) ?? 1000
        }
        return 1000
    }

    @State private var dateString: String = ""
    @State private var date: Date
    @State private var appName: String
    @State private var time: String
    @FocusState private var isFocused: Bool

    init(records: [Record], record: Record? = nil) {
        self.records = records
        self.record = record

        _date = State(initialValue: record?.startDate ?? Date())
        _appName = State(initialValue: record?.name ?? "")
        _time = State(initialValue: record.map { String($0.time) } ?? "")
    }

    @State private var showWarning: Bool = false
    @State private var showSuccess: Bool = false

    let notification: NotificationSettings = NotificationSettings()

    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()

    var filter: RecordFilter { RecordFilter(records: records, currentDate: Date()) }

    var body: some View {
        VStack {
            HStack {
                Text(record == nil ? LocalizedStringKey("New") : LocalizedStringKey("Edit"))
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            VStack {
                HStack {
                    Text("Date")
                    Spacer()
                }
                HStack {
                    TextField("", text: $dateString)
                        .focused($isFocused)
                        .onAppear {
                            dateString = Self.formatter.string(from: date)
                        }
                        .onChange(of: isFocused) {
                            if !isFocused {
                                if let newDate = Self.formatter.date(from: dateString) {
                                    date = newDate
                                    dateString = Self.formatter.string(from: date)
                                } else {
                                    dateString = Self.formatter.string(from: date)
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
                    Text("App Name")
                    Spacer()
                }
                TextField("Example: Instagram", text: $appName)
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
                    Text("Used time (minutes)")
                    Spacer()
                }
                TextField("Example: 120", text: $time)
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
            HStack {
                Button {
                    Task {
                        save()
                        // Update notification if pending
                        let weekly = await notification.isPending("Weekly Report")
                        let monthly = await notification.isPending("Monthly Report")
                        if weekly.isPending {
                            let totalTime = filter.thisWeek.reduce(0) { $0 + $1.time }
                            notification.deleteNotification("Weekly Report")
                            notification.scheduleNotifications(
                                id: "Weekly Report",
                                earnings: timeWageToDoubleLoss(time: totalTime, wage: wage),
                                time: timeToString(time: totalTime),
                                components: weekly.components ?? DateComponents()
                            )
                        }
                        if monthly.isPending {
                            let totalTime = filter.thisMonth.reduce(0) { $0 + $1.time }
                            notification.deleteNotification("Monthly Report")
                            notification.scheduleNotifications(
                                id: "Monthly Report",
                                earnings: timeWageToDoubleLoss(time: totalTime, wage: wage),
                                time: timeToString(time: totalTime),
                                components: weekly.components ?? DateComponents()
                            )
                        }
                    }
                } label: {
                    Text("save")
                        .frame(maxWidth: 100, minHeight: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.blue)
                        )
                }
                Spacer()
                if record != nil {
                    Button(action: delete) {
                        Text("Delete")
                            .frame(maxWidth: 100, minHeight: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.red)
                            )
                    }
                }
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
                toast(text: "There are empty fields.", color: .red)
            }
        }
        .overlay(alignment: .top) {
            if showSuccess && record == nil {
                toast(
                    text: record == nil
                        ? "New record saved"
                        : "Record updated",
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
                Text("Edit")
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
                dateString = Self.formatter.string(from: newValue)
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

    func delete() -> Void {
        if let record {
            modelContext.delete(record)
            dismiss()
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
