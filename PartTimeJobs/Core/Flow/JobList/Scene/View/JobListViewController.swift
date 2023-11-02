//
//  JobListViewController.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 02.11.2023.
//

import UIKit

final class JobListViewController: UIViewController {
    
    // MARK: - Property
    var presenter: JobListPresenterProtocol!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelf()
    }
}

// MARK: - Private methods
private extension JobListViewController {
    
    func setupSelf() {
        view.backgroundColor = .brown
    }
}

// MARK: - JobListViewProtocol
extension JobListViewController: JobListViewProtocol {
    
}
