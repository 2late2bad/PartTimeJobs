//
//  UserDefaults+ext.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 05.11.2023.
//

import Foundation.NSUserDefaults

extension UserDefaults {
    
    private enum Keys {
        static let selectedID = "selectedJobsForId"
    }
    
    class var selectedID: [String] {
        get {
            if let array = standard.stringArray(forKey: Keys.selectedID) {
                return array
            } else { return [] }
        }
        set {
            standard.set(newValue, forKey: Keys.selectedID)
        }
    }
}
