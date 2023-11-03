//
//  JobListPresenter.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 02.11.2023.
//

import Foundation

protocol JobListViewProtocol: AnyObject {
    func updateCollection(with data: [Job], selectedPaths: [IndexPath])
}

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
    
    func fetchData() {
        // >DEBUG
        let debugData: [Job] = [
            .init(id: "1", profession: "Грузчик", employer: "Озон", salary: 1600, date: .now, logo: nil),
            .init(id: "2", profession: "Монтажник", employer: "ОЗОН", salary: 200, date: .now, logo: nil),
            .init(id: "3", profession: "Разработчик", employer: "Пятерочка", salary: 14400, date: .now, logo: nil),
            .init(id: "4", profession: "Строитель", employer: "Шелф", salary: 1200, date: .now, logo: nil),
            .init(id: "5", profession: "Монтажник", employer: "ОЗОН", salary: 200.12, date: .now, logo: nil),
            .init(id: "6", profession: "Разработчик", employer: "Пятерочка", salary: 14400, date: .now, logo: nil),
            .init(id: "7", profession: "Строитель", employer: "Шелф", salary: 1200.00, date: .now, logo: nil),
            .init(id: "8", profession: "Монтажник", employer: "ОЗОН", salary: 200, date: .now, logo: nil),
            .init(id: "9", profession: "Разработчик", employer: "Пятерочка", salary: 14400, date: .now, logo: nil),
            .init(id: "10", profession: "Коп", employer: "Пятерочка", salary: 0.01, date: .now, logo: nil),
            .init(id: "11", profession: "Копр", employer: "Пятерочка", salary: 14400, date: .now, logo: nil),
            .init(id: "12", profession: "Копро", employer: "Пятерочка", salary: 5555.55, date: .now, logo: nil)
        ]
        view.updateCollection(with: debugData, selectedPaths: [])
    }
    
    func bookingButtonTapped() {
        
    }
    
    func updateSearchController(searchBarText: String?) {
        
    }
}
