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
    func configure(with title: String?, isActive: Bool) {
        setTitleKeepingFont(title)
        isEnabled = isActive
    }
    
    private func setupSelf() {
        startAnimatingPressActions()
        translatesAutoresizingMaskIntoConstraints = false
        isEnabled = false
        
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = R.Colors.mainInteractive.ui
        configuration.baseForegroundColor = .label
        configuration.background.cornerRadius = 7
        configuration.background.strokeWidth = 0.5
        configuration.background.strokeColor = R.Colors.borderDefault.ui.withAlphaComponent(0.04)
        
        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 15, weight: .semibold)
        configuration.attributedTitle = AttributedString("Выберите подработки", attributes: container)
        
        self.configuration = configuration
    }
    
    override func updateConfiguration() {
        var updatedConfiguration = configuration
        switch state {
        case .normal:
            updatedConfiguration?.background.backgroundColor = R.Colors.mainInteractive.ui
        case .highlighted:
            updatedConfiguration?.background.backgroundColor = R.Colors.mainInteractive.ui.withAlphaComponent(0.5)
        case .disabled:
            updatedConfiguration?.background.backgroundColor = R.Colors.secondaryInteractive.ui
        default: break
        }
        self.configuration = updatedConfiguration
    }
}
