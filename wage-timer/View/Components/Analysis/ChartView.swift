//
//  ChartView.swift
//  wage-timer
//
//  Created by 乙津　龍　 on 21/12/2025.
//

import SwiftUI
import Charts

struct ChartView: View {
    var data: [ValuePerCategory]

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

//#Preview {
//    ChartView()
//}
