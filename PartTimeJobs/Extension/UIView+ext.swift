//
//  UIView+ext.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 02.11.2023.
//

import UIKit.UIView

extension UIView {
    
    func addSubviews(_ views: UIView...) { views.forEach { addSubview($0) } }
    
    enum LocalName {
        static let OutsideBorder = "borderLayer"
    }
    
    func addOutsideBorder(borderWidth: CGFloat, borderColor: UIColor) {
        if let sublayers = layer.sublayers {
            for layer in sublayers {
                if layer.name == LocalName.OutsideBorder {
                    layer.removeFromSuperlayer()
                }
            }
        }
        
        let borderLayer = CAShapeLayer()
        borderLayer.name = LocalName.OutsideBorder
        
        let halfBorderWidth = borderWidth / 2
        let path = UIBezierPath(
            roundedRect: bounds.insetBy(dx: -halfBorderWidth, dy: -halfBorderWidth),
            cornerRadius: layer.cornerRadius
        )
        
        borderLayer.lineWidth = borderWidth
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.path = path.cgPath
        
        layer.addSublayer(borderLayer)
    }
    
    func setShadow(
        color: UIColor,
        alpha: CGFloat,
        radius: CGFloat,
        cornerRadius: CGFloat,
        shadowOffest: CGSize = .zero,
        shadowOpacity: Float = 1
    ) {
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        layer.shadowColor = color.withAlphaComponent(alpha).cgColor
        layer.shadowRadius = radius
        layer.shadowOffset = shadowOffest
        layer.shadowOpacity = shadowOpacity
    }
    
    func removeShadow() {
        layer.shadowColor = nil
        layer.shadowOpacity = 0
        layer.shadowOffset = .zero
        layer.shadowRadius = 0
    }
    
    func removeSubLayers() {
        if let sublayers = layer.sublayers {
            for layer in sublayers {
                if layer.name == LocalName.OutsideBorder {
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
}
