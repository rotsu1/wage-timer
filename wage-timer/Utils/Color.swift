//
//  Color.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 15/12/2025.
//

import SwiftUI

extension Color {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> Color{
        return self.init(red: red/255, green: green/255, blue: blue/255)
    }
    static func rgbo(red: CGFloat, green: CGFloat, blue: CGFloat, opacity: Double) -> Color{
        return self.init(red: red/255, green: green/255, blue: blue/255, opacity: opacity)
    }
}

let backgroundGradient = LinearGradient(
    colors: [Color.rgb(red: 1, green: 53, blue: 150), Color.black],
    startPoint: .top, endPoint: .bottom)
