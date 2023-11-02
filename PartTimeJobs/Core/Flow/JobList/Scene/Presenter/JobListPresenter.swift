//
//  JobListPresenter.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 02.11.2023.
//

import Foundation

final class JobListPresenter {
    
    // MARK: - Property
    private weak var view: JobListViewProtocol!
    private var model: JobListModel
    
    // MARK: - Init
    init(view: JobListViewProtocol, model: JobListModel) {
        self.view = view
        self.model = model
    }
}

// MARK: - JobListPresenterProtocol
extension JobListPresenter: JobListPresenterProtocol {
    
}
