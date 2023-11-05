//
//  JobListPresenterProtocol.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 04.11.2023.
//

protocol JobListPresenterProtocol {
    init(view: JobListViewProtocol, model: JobListModel, networkService: NetworkService)
    func viewDidLoad()
    func bookingButtonTapped()
    func didSelectJob(_ job: Job)
    func didDeselectJob(_ job: Job)
    func updateSearchController(searchBarText: String?)
}
