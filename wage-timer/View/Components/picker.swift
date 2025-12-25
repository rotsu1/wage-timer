//
//  picker.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 24/12/2025.
//
import SwiftUI

func pickerRow<T: Hashable>(
    image: String, 
    title: String, 
    values: [(key: String, value: T)], 
    bind: Binding<T>,
    color: Color = Color.rgbo(red: 179, green: 179, blue: 179, opacity: 1)
) -> some View {
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
        .tint(color)
        .fontWeight(.light)
    }
}