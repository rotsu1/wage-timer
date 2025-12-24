//
//  picker.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 24/12/2025.
//
import SwiftUI

func pickerRow(image: String, title: String, values: [(key: String, value: String)], bind: Binding<String>) -> some View {
    HStack {
        HStack {
            if !image.isEmpty {
                Image(systemName: image)
            }
            Text(title)
        }
        .foregroundStyle(.white)
        Spacer()
        Picker("", selection: bind) {
            ForEach(values, id: \.value) { pair in
                Text(pair.key).tag(pair.value)
            }
        }
        .pickerStyle(.menu)
        .tint(Color.rgbo(red: 179, green: 179, blue: 179, opacity: 1))
        .fontWeight(.light)
    }
}