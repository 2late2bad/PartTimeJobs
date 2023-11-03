//
//  Utils.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 03.11.2023.
//

import Foundation

struct Utils {
    
    /// Возвращает строку с учетом склонения по числу 'count'.
    /// Необходимо указать склонение для случаев: один, несколько, много
    static func pluralForm(for count: Int, one: String, few: String, many: String) -> String {
        let cases = [one, few, many]
        let rem100 = count % 100
        let rem10 = count % 10
        switch true {
        case rem100 > 10 && rem100 < 20:
            return cases[2]
        case rem10 == 1:
            return cases[0]
        case rem10 > 1 && rem10 < 5:
            return cases[1]
        default:
            return cases[2]
        }
    }
}
