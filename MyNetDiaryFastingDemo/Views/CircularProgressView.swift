//
//  CircularProgressView.swift
//  MyNetDiaryFastingDemo
//
//  Created by Ace Green on 2023-08-05.
//

import SwiftUI

struct CircularProgressView<Label: View, CurrentValueLabel: View>: View {
    @ViewBuilder var label: Label
    @ViewBuilder var currentValueLabel: CurrentValueLabel
    var progress: Double

    var body: some View {
        ProgressView(value: progress,
                     label: { label },
                     currentValueLabel: { currentValueLabel })
        .progressViewStyle(CircularProgressStyle())
    }
}

//#Preview {
//    let startDate: Date = Date().addingTimeInterval(-24 * 60 * 60)
//    let endDate: Date = Date().addingTimeInterval(24 * 60 * 60)
//    let progress: Double = 0.50
//    CircularProgressView(label: {
//        Text("Elapsed (\(progress.formatted(.percent.precision(.fractionLength(0)))))")
//            .font(.caption)
//            .foregroundStyle(.gray)
//            .bold()
//    }, currentValueLabel: {
//        Text(startDate, style: .timer)
//            .font(.title2)
//            .bold()
//    }, progress: 0.50)
//    .frame(width: 200, height: 200)
//}
