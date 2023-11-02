//
//  BaseStackView.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 02.11.2023.
//

import UIKit

public class BaseStackView: UIStackView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(
        axis: NSLayoutConstraint.Axis = .horizontal,
        alignment: UIStackView.Alignment = .center,
        distribution: UIStackView.Distribution = .equalSpacing
    ) {
        self.init(frame: .zero)
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
