//
//  JobCell.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 02.11.2023.
//

import UIKit

final class JobCell: UICollectionViewCell {
    
    // MARK: - Public property
    var identifier: String?
    
    // MARK: - Private property
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var professionLabel = BaseLabel(font: .systemFont(ofSize: 17, weight: .semibold),
                                                 color: .label,
                                                 alignment: .center,
                                                 lines: 1)
    private lazy var salaryView = InfoView()
    private lazy var logoStackView = LogoStackView()
    private lazy var timeStackView = TimeStackView()
    private lazy var topInfoStackView = BaseStackView(axis: .horizontal)
    private lazy var bottomInfoStackView = BaseStackView(axis: .horizontal)
    
    // MARK: - Override property
    override var isSelected: Bool {
        didSet {
            setSelected(isSelected)
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
    
    // MARK: - Override methods
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 15
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // TODO: - ?????
        //setSelected(false)
    }

    // MARK: - Configure cell
    func configure(with job: Job) {
        identifier = job.id
        professionLabel.text = job.profession
        salaryView.configure(type: .price(salary: job.salary))
        logoStackView.configure(image: UIImage(systemName: "people"), label: job.employer)
        timeStackView.configure(with: job.date)
    }
}

// MARK: - Private methods
private extension JobCell {
    
    func setSelected(_ isSelected: Bool) {
        if isSelected {
            addOutsideBorder(borderWidth: 2.0, borderColor: R.Colors.mainInteractive.ui)
            addShadowDefault(color: R.Colors.mainInteractive.ui, alpha: 0.6, radius: 4, cornerRadius: 15)
        } else {
            removeSubLayers()
            removeShadow()
        }
    }
    
    func setupSelf() {
        backgroundColor = R.Colors.listItemBackground.ui
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(topInfoStackView)
        containerStackView.addSeparator(of: 1, color: R.Colors.divider.ui)
        containerStackView.addArrangedSubview(bottomInfoStackView)
        topInfoStackView.addArrangedSubview(professionLabel)
        topInfoStackView.addArrangedSubview(salaryView)
        bottomInfoStackView.addArrangedSubview(logoStackView)
        bottomInfoStackView.addArrangedSubview(timeStackView)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            professionLabel.heightAnchor.constraint(equalToConstant: 32),
        ])
    }
}
