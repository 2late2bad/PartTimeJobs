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
    
    convenience init(
        backgroundColor: UIColor = R.Colors.mainElementBackground.uiColor,
        title: String = "Выберите подработки"
    ) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 7
    }
    
    // MARK: - Methods
    func configure(with title: String, isActive: Bool) {
        self.setTitle(title, for: .normal)
        self.isEnabled = isActive
        self.backgroundColor =
        isActive ?
        R.Colors.mainElementBackground.uiColor :
        R.Colors.secondaryElementBackground.uiColor
    }
    
    private func setupSelf() {
        titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        setTitleColor(.label, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
