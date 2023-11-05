//
//  UIWindow+ext.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 05.11.2023.
//

import UIKit.UIWindow

extension UIWindow {
    
    /// Корректное получение ключевого окна сцены, в которой обращаемся к этому свойству
    static var keyWindow: UIWindow? {
        let allScenes = UIApplication.shared.connectedScenes
        for scene in allScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows where window.isKeyWindow {
                return window
            }
        }
        return nil
    }
}
