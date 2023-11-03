//
//  BookingButton.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 02.11.2023.
//

import UIKit

final class BookingButton: UIButton {
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configure(with title: String, isActive: Bool) {
        setTitleKeepingFont(title)
        isEnabled = isActive
    }
    
    private func setupSelf() {
        translatesAutoresizingMaskIntoConstraints = false
        isEnabled = false
        
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = R.Colors.mainInteractive.ui
        configuration.baseForegroundColor = .label
        configuration.background.cornerRadius = 7
        
        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 15, weight: .semibold)
        configuration.attributedTitle = AttributedString("Выберите подработки", attributes: container)
        
        self.configuration = configuration
    }
}
