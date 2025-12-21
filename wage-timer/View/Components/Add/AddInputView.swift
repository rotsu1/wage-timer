//
//  AddInputView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 21/12/2025.
//
import SwiftUI

struct AddInputView: View {
    var body: some View {
        VStack {
            HStack {
                Text("新規")
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
                    Text("2025/12/12")
                    Spacer()
                    Image(systemName: "calendar")
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
                HStack {
                    Text("例:インスタ")
                    Spacer()
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
                    Text("使用時間（分）")
                    Spacer()
                }
                HStack {
                    Text("例：120")
                    Spacer()
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
            HStack {
                Text("保存")
                    .frame(maxWidth: 100, minHeight: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.blue)
                    )
                Spacer()
            }
            .padding()
        }
        .foregroundStyle(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.3))
        )
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.rgbo(red: 242, green: 118, blue: 118, opacity: 0.1))
        )
    }
}

#Preview {
    AddInputView()
}
