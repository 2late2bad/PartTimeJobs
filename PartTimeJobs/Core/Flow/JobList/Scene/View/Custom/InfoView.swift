//
//  InfoView.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 02.11.2023.
//

import UIKit

final class InfoView: UIView {
    
    enum TypeView {
        case price(salary: Double)
        case common(value: String)
    }
    
    // MARK: - Property
    private var label = BaseLabel(font: .systemFont(ofSize: 12, weight: .medium),
                                  color: .label,
                                  alignment: .center,
                                  lines: 1)
    
    var labelText: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
            invalidateIntrinsicContentSize()
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 4
    }

    // MARK: - Methods
    func configure(type: TypeView) {
        switch type {
        case .price(let salary):
            backgroundColor = R.Colors.mainInteractive.ui
            labelText = "\(salary.stringDecimal) ₽"
        case .common(let value):
            backgroundColor = R.Colors.secondaryInteractive.ui
            labelText = value
        }
    }
    
    private func setupSelf() {
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
    }
}
