//
//  NotificationView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 24/12/2025.
//
import SwiftUI
import SwiftData

struct NotificationView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var notifications: [Notification]

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundGradient
                    .ignoresSafeArea()
                VStack {                  
                    if notifications.isEmpty {
                        VStack {
                            Image(systemName: "bell")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .aspectRatio(contentMode: .fit)
                                .padding(.vertical, 16)
                            Text("最近の通知はありません")
                                .fontWeight(.bold)
                                .font(.title)
                                .padding(.bottom, 8)
                            Text("新しいアクティビティがある場合に通知します")
                        }
                    } else {
                        ForEach(notifications.prefix(50), id: \.self) { notification in
                            notificationCard(notification: notification)
                        }
                    }
                    
                    Spacer()
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 16)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("通知")
                    .foregroundColor(.white)
            }
        }
    }
}

func notificationCard(notification: Notification) -> some View {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd"
    let dateString = formatter.string(from: notification.date)

    return HStack {
        Image(systemName: notification.image)
        VStack {
            HStack {
                Text(dateString)
                Spacer()
            }
            Text(notification.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(notification.context)
                .frame(maxWidth: .infinity, alignment: .leading)
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

#Preview {
    NotificationView()
}
