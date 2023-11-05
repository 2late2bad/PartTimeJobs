//
//  String+ext.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 05.11.2023.
//

import Foundation

extension String {
    func containsFromRuKeyboard(_ searchText: String) -> Bool {
        self.lowercased().contains(searchText) ||
        self.lowercased().contains(searchText.replacingOccurrences(of: "е", with: "ё")) ||
        self.lowercased().contains(searchText.replacingOccurrences(of: "ь", with: "ъ"))
    }
}
