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
    private let networkService: NetworkService
    private var totalIncome: Double {
        model.allJobs.reduce(0) { result, job in
            model.selectedJobsById.contains(job.id) ? result + job.salary : result
        }
    }
    
    // MARK: - Init
    init(view: JobListViewProtocol, model: JobListModel, networkService: NetworkService) {
        self.view = view
        self.model = model
        self.networkService = networkService
    }
    
    // MARK: - Private methods
    private func setupButton() {
        if !model.selectedJobsById.isEmpty {
            let jobCount = model.selectedJobsById.count
            let word = Utils.PluralForm(for: jobCount, one: "подработку", few: "подработки", many: "подработок")
            view?.updateButton(with: "Забронировать \(jobCount) \(word)", isActive: true)
        } else {
            view?.updateButton(with: "Выберите подработки", isActive: false)
        }
    }
}

// MARK: - JobListPresenterProtocol
extension JobListPresenter: JobListPresenterProtocol {
    
    @MainActor
    func viewDidLoad() {
        Task {
            do {
                let jobs: [Job] = try await networkService.request(.get)
                model.updateJobs(jobs)
                view.updateCollection(with: model.allJobsData)
                setupButton()
            } catch(let error as NetworkError) {
                // Без обработки ошибок
                #if DEBUG
                print(">DEBUG>")
                print("ОШИБКА:", error.message)
                #endif
            }
        }
    }
    
    func didSelectJob(_ job: Job) {
        model.selectedJobsById.insert(job.id)
        setupButton()
    }
    
    func didDeselectJob(_ job: Job) {
        model.selectedJobsById.remove(job.id)
        setupButton()
    }
    
    func bookingButtonTapped() {
        let alertTitle: String = "Успех"
        let alertMessage: String = "Вы заработали \(totalIncome.stringDecimal) рублей"
        view.showAlert(title: alertTitle, message: alertMessage)
    }
    
    func updateSearchController(searchBarText: String?) {
        guard let searchText = searchBarText?.lowercased(),
                  !searchText.isEmpty
        else {
            view.updateCollection(with: model.allJobsData)
            return
        }
        
        let filteredJobs = model.allJobs.filter { job in
            job.profession.containsFromRuKeyboard(searchText) ||
            job.employer.containsFromRuKeyboard(searchText)
        }
        
        let filteredItems = filteredJobs.map { SectionItem.jobs($0) }
        
        let selectedJobsDict = model.selectedJobsById.reduce(into: [String: Bool]()) { result, id in
            result[id] = true
        }
        
        let selectedPaths = filteredJobs.enumerated().compactMap { index, job in
            selectedJobsDict[job.id] != nil ? IndexPath(item: index, section: Section.jobs.rawValue) : nil
        }
        
        let filteredJobsData = SectionData(key: .jobs, values: filteredItems, selectedPath: selectedPaths)
        view.updateCollection(with: filteredJobsData)
    }
}
