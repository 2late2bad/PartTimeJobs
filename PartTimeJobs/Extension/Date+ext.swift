//
//  Date+ext.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 02.11.2023.
//

import Foundation

extension Date {
    
    var convertMonthYear: String {
        self.formatted(
            .dateTime
                .day(.twoDigits)
                .month(.twoDigits)
                .locale(Locale(identifier: "ru_RU"))
        )
    }
    
    var convertTime: String {
        self.formatted(
            .dateTime
                .hour()
                .minute()
                .locale(Locale(identifier: "ru_RU"))
        )
    }
}
