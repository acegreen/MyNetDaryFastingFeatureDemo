//
//  FastGridView.swift
//  MyNetDiaryFastingDemo
//
//  Created by Ace Green on 2023-08-05.
//

import SwiftUI

struct FastGridView: View {
    @Environment(\.dismiss) var dismiss

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var callback: ((_ fast: Fast) -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Fast Schedule")
                .font(.title2)
                .fontWeight(.semibold)
            LazyVGrid(columns: columns) {
                ForEach(Fast.allCases, id: \.rawValue) { fast in
                    Button {
                        callback?(fast)
                        dismiss()
                    } label: {
                        CardView(title: fast.description,
                                 goal: fast.rawValue,
                                 backgroundColor: fast.color)
                    }
                }
            }
        }
        //        .padding(.horizontal)
    }
}

struct CardView: View{
    let title: String
    let goal: Double
    let backgroundColor: Color
    private let cardWidth: CGFloat = 100
    private let cardHeight: CGFloat = 120
    private let cornerRadius: CGFloat = 10

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .frame(width: cardWidth, height: cardHeight)
                .foregroundStyle(backgroundColor)
                .brightness(-0.30)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.footnote)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                Spacer()
                LazyVStack(alignment: .leading, spacing: -2) {
                    Text("\(goal, specifier: "%.0f")")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("hours")
                        .font(.callout)
                        .foregroundColor(.white)
                }
            }
            .padding()
            .frame(width: cardWidth, height: cardHeight)
            .cornerRadius(cornerRadius)
        }
    }
}

#Preview {
    FastGridView(callback: nil)
        .previewLayout(.sizeThatFits)
}
