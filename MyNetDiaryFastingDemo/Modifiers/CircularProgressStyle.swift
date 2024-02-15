//
//  CircularProgressStyle.swift
//  MyNetDiaryFastingDemo
//
//  Created by Ace Green on 2023-08-07.
//

import SwiftUI

struct CircularProgressStyle: ProgressViewStyle {

    var color: Color = .green
    var labelFontStyle: Font = .caption
    var currentValueLabelFontStyle: Font = .title2

    @ViewBuilder
    func makeBody(configuration: Configuration) -> some View {
        let progress = configuration.fractionCompleted ?? 0.0

        GeometryReader { geometry in
            ZStack {
                Circle()
                    .stroke(
                        color.opacity(0.5),
                        lineWidth: 15
                    )
                    .overlay {
                        Circle()
                            .trim(from: 0, to: progress)
                            .stroke(
                                color,
                                style: StrokeStyle(
                                    lineWidth: 15,
                                    lineCap: .round
                                )
                            )
                            .rotationEffect(.degrees(-90))
                            .animation(.easeOut, value: progress)
                    }
            }
            .overlay {
                VStack {
                    configuration.label
                        .font(labelFontStyle)
                        .bold()
                    if let currentValueLabel = configuration.currentValueLabel {
                        currentValueLabel
                            .font(currentValueLabelFontStyle)
                            .bold()
                    }
                }
            }
        }
    }
}
