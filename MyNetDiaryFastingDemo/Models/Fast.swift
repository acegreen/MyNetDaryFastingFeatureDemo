//
//  Fast.swift
//  MyNetDiaryFastingDemo
//
//  Created by Ace Green on 2023-08-05.
//

import SwiftUI

enum FastStatus: CaseIterable {
    case fasting
    case none
}

enum Fast: CaseIterable, CustomStringConvertible {
    case twelve
    case sixteen
    case eighteen
    case twentie
    case thirtySix
    case custom(TimeInterval)

    static var allCases: [Fast] {
        return [.twelve, .sixteen, .eighteen, .twentie, .thirtySix, .custom(48)]
    }

    var rawValue: TimeInterval {
        switch self {
        case .twelve:
            return 12
        case .sixteen:
            return 16
        case .eighteen:
            return 18
        case .twentie:
            return 20
        case .thirtySix:
            return 36
        case .custom(let length):
            return length
        }
    }

    var description: String {
        switch self {
        case .twelve:
            return "Circadian Rhymthm"
        case .sixteen:
            return "16:8"
        case .eighteen:
            return "18:6"
        case .twentie:
            return "20:4"
        case .thirtySix:
            return "36-hour"
        case .custom:
            return "Custom Fast"
        }
    }

    var color: Color {
        switch self {
        case .twelve:
            return .purple
        case .sixteen:
            return .pink
        case .eighteen:
            return .green
        case .twentie:
            return .yellow
        case .thirtySix:
            return .blue
        case .custom:
            return .gray
        }
    }

    func goal(from startDate: Date) -> Date {
        return startDate.addingTimeInterval(self.rawValue * 60 * 60)
    }
}
