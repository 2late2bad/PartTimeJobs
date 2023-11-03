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

final class JobListPresenter {
    
    // MARK: - Property
    private weak var view: JobListViewProtocol!
    private var model: JobListModel
    private let networkService: JobNetworkService
    
    // TODO: -
    var selectedPaths: [IndexPath] = []
    var selectedJobsId: Set<String> = Set() {
        didSet {
            setupButton()
        }
    }
    
    // MARK: - Init
    init(view: JobListViewProtocol, model: JobListModel, networkService: JobNetworkService) {
        self.view = view
        self.model = model
        self.networkService = networkService
    }
    
    // MARK: - Private methods
    
}

// MARK: - JobListPresenterProtocol
extension JobListPresenter: JobListPresenterProtocol {
    
    // TODO: -
    func viewDidLoad() {
//        var selectedPaths: [IndexPath] = []
//        let jobs: [JobModel] = sectionData.getJobs()
//        for (index, value) in jobs.enumerated() {
//            if selectedJobsId.contains(value.id) {
//                selectedPaths.append([0, index])
//            }
//        }
        
        Task {
            do {
                let jobs = try await networkService.fetchJobs()
                model.updateJobs(jobs)
                view.updateCollection(with: model.allJobs, selectedPaths: [])
            } catch {
                print(error.localizedDescription)
            }
        }
//        setupButton()
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
            let word = Utils.PluralForm(for: jobCount, one: "подработку", few: "подработки", many: "подработок")
            view?.updateButton(with: "Забронировать \(jobCount) \(word)", isActive: true)
        } else {
            view?.updateButton(with: "Выберите подработки", isActive: false)
        }
    }
    
    func updateSearchController(searchBarText: String?) {
        
    }
}
