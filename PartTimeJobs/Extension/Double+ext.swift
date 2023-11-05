//
//  Double+ext.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 02.11.2023.
//

import Foundation

extension Double {
    
    // Отображение стиля .decimal согласено локалей:
    /// en_US: 1,234.568
    /// fr_FR: 1 234,568
    /// zh_CN: 1,234.568
    var stringDecimal: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "fr_FR")
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}
