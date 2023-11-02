//
//  Resources.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 02.11.2023.
//

import UIKit

typealias R = Resources

enum Resources {
    
    enum API {
        static let jobs = "http://185.174.137.159/jobs"
    }
    
    enum Constants {
        
    }
    
    enum Colors {
        /// Job List Screen
        case viewBackground
        case collectionViewBackground
        case listItemBackground
        case mainElementBackground
        case secondaryElementBackground
        case divider
        
        var uiColor: UIColor {
            switch self {
            case .viewBackground, .listItemBackground:
                return hexStringToUIColor(hex: "#FFFFFF")
            case .collectionViewBackground, .divider:
                return hexStringToUIColor(hex: "#EEEEEE")
            case .mainElementBackground:
                return hexStringToUIColor(hex: "#F7CE17")
            case .secondaryElementBackground:
                return hexStringToUIColor(hex: "#DEDEDE")
            }
        }
    }
}

fileprivate extension R.Colors {
    
    func hexStringToUIColor(hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
