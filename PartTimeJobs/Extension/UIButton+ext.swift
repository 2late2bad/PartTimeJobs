//
//  UIButton+ext.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 02.11.2023.
//

import UIKit.UIButton

// MARK: - Content
extension UIButton {
    
    func setTitleKeepingFont(_ title: String?) {
        guard
            configuration != nil,
            let title,
            let currentFont = titleLabel?.font
        else {
            setTitle(title, for: .normal)
            return
        }
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: currentFont
        ]
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        setAttributedTitle(attributedTitle, for: .normal)
    }
}

// MARK: - Animations
extension UIButton {
    
    func startAnimatingPressActions() {
        addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }
    
    @objc private func animateDown(sender: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.allowUserInteraction, .curveEaseIn], animations: {
            self.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
        }, completion: nil)
    }
    
    @objc private func animateUp(sender: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.allowUserInteraction, .curveEaseOut], animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
