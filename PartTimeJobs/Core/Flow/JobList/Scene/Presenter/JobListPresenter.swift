//
//  JobListPresenter.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 02.11.2023.
//

import Foundation

protocol JobListViewProtocol: AnyObject {
    func updateButton(with title: String, isActive: Bool)
    func showAlert(title: String, message: String)
    func updateCollection(with data: SectionData, selectedPaths: [IndexPath])
}

final class JobListPresenter: JobListPresenterProtocol {
    
    // MARK: - Property
    private weak var view: JobListViewProtocol!
    private let model: JobListModel

    var selectedPaths: [IndexPath] = []
    var selectedJobsId: Set<String> = Set() {
        didSet {
            setupButton()
        }
    }
    
    // MARK: - Init
    init(view: JobListViewProtocol, model: JobListModel) {
        self.view = view
        self.model = model
    }
    
    func viewDidLoad() {
//        var selectedPaths: [IndexPath] = []
//        let jobs: [JobModel] = sectionData.getJobs()
//        for (index, value) in jobs.enumerated() {
//            if selectedJobsId.contains(value.id) {
//                selectedPaths.append([0, index])
//            }
//        }
        setupButton()
        view.updateCollection(with: model.allJobData, selectedPaths: [])
    }
    
    func didSelectJob(id: String) {
        selectedJobsId.insert(id)
    }
    
    func didDeselectJob(id: String) {
        selectedJobsId.remove(id)
    }
    
    func bookingButtonTapped() {
        let alertTitle: String = "Успех"
        let alertMessage: String = "Вы заработали \(1000.00.stringDecimal) рублей"
        
        view?.showAlert(title: alertTitle, message: alertMessage)
    }

    func setupButton() {
        if !selectedJobsId.isEmpty {
            let jobCount = selectedJobsId.count
            let word = Utils.pluralForm(for: jobCount, one: "подработку", few: "подработки", many: "подработок")
            view?.updateButton(with: "Забронировать \(jobCount) \(word)", isActive: true)
        } else {
            view?.updateButton(with: "Выберите подработки", isActive: false)
        }
    }
    
    func updateSearchController(searchBarText: String?) {
        
    }
}

// MARK: - Private methods
private extension JobListPresenter {
    
}
