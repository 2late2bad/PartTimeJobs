//
//  LogoStackView.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 02.11.2023.
//

import UIKit

final class LogoStackView: UIStackView {
    
    enum LocalConstant {
        static let borderImage = 1.0
    }
    
    // MARK: - Property
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderColor = R.Colors.imageBorder.ui.cgColor
        imageView.layer.borderWidth = LocalConstant.borderImage
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = R.Colors.secondaryInteractive.ui
        return imageView
    }()
    
    private var label = BaseLabel(font: .systemFont(ofSize: 13, weight: .semibold),
                                  color: .label,
                                  alignment: .center,
                                  lines: 1)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSelf()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
    }
    
    // MARK: - Methods
    func prepareForReuse() {
        imageView.image = nil
    }
    
    func configure(imageUrl: String?, label: String?) {
        self.label.text = label
        
        ImageLoader.instance.downloadImage(from: imageUrl) { [weak self] data in
            guard let self else { return }
            DispatchQueue.main.async {
                if let data {
                    self.imageView.image = UIImage(data: data)
                } else {
                    self.imageView.image = UIImage(systemName: R.Constants.logoImageDefault)
                }
            }
        }
    }
    
    private func setupSelf() {
        axis = .horizontal
        spacing = 12
        translatesAutoresizingMaskIntoConstraints = false
        addArrangedSubview(imageView)
        addArrangedSubview(label)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 32),
            imageView.widthAnchor.constraint(equalToConstant: 32)
        ])
    }
}
