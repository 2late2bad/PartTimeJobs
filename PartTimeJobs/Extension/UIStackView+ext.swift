//
//  UIStackView+ext.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 02.11.2023.
//

import UIKit.UIStackView

extension UIStackView {
    
    func addSeparator(of size: CGFloat = 1.0, color: UIColor? = .black) {
        let view = UIView()
        view.backgroundColor = color
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if axis == .vertical {
            view.heightAnchor.constraint(equalToConstant: size).isActive = true
        } else {
            view.widthAnchor.constraint(equalToConstant: size).isActive = true
        }
        
        addArrangedSubview(view)
    }
}
