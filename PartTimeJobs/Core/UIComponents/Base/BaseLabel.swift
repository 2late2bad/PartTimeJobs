//
//  BaseLabel.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 02.11.2023.
//

import UIKit

public class BaseLabel: UILabel {
    
    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupSelf()
    }
    
    convenience init(font: UIFont, color: UIColor, alignment: NSTextAlignment, lines: Int) {
        self.init(frame: .zero)
        self.font = font
        self.textColor = color
        self.textAlignment = alignment
        self.numberOfLines = lines
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupSelf() {
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.8
        lineBreakMode = .byTruncatingTail
    }
}
