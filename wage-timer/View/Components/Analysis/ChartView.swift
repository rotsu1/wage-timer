//
//  ChartView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 21/12/2025.
//

import SwiftUI
import Charts

struct ValuePerCategory {
    var category: String
    var value: Double
}

let data: [ValuePerCategory] = [
    .init(category: "1月", value: -1000),
    .init(category: "2月", value: -2000),
    .init(category: "3月", value: -20000),
    .init(category: "4月", value: -1000),
    .init(category: "5月", value: -2000),
    .init(category: "6月", value: -20000),
    .init(category: "7月", value: -1000),
    .init(category: "8月", value: -2000),
    .init(category: "9月", value: -20000),
    .init(category: "10月", value: -1000),
    .init(category: "11月", value: -2000),
    .init(category: "12月", value: -20000),
]

struct ChartView: View {
    var body: some View {
        Chart(data, id: \.category) { item in
            LineMark(
                x: .value("Category", item.category),
                y: .value("Value", item.value)
            )
        }
        .chartXAxis {
            AxisMarks {
                AxisGridLine()
                    .foregroundStyle(.white)
                AxisValueLabel()
                    .foregroundStyle(.white)
            }
        }
        .chartYAxis {
            AxisMarks {
                AxisGridLine()
                    .foregroundStyle(.white)
                AxisValueLabel()
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    ChartView()
}
