//
//  TimeStackView.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 02.11.2023.
//

import UIKit

final class TimeStackView: UIStackView {
    
    // MARK: - Property
    private let dataView = InfoView()
    private let timeView = InfoView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSelf()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configure(with date: Date) {
        dataView.configure(type: .common(value: date.convertMonthYear))
        timeView.configure(type: .common(value: date.convertTime))
    }
    
    private func setupSelf() {
        axis = .horizontal
        spacing = 4
        addArrangedSubview(dataView)
        addArrangedSubview(timeView)
    }
}
