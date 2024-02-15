//
//  Date+Extensions.swift
//  MyNetDiaryFastingDemo
//
//  Created by Ace Green on 2023-08-05.
//

import Foundation

extension Date {
    var dashboardDateFormat: String {
        self.formatted(
            .dateTime
                .month(.abbreviated)
                .day()
            
        )
    }

    var dashboardHourFormat: String {
        self.formatted(
            .dateTime
                .hour()
                .minute()
        )
    }
}
