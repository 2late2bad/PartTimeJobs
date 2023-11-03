//
//  JobListViewController.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 02.11.2023.
//

import UIKit

protocol JobListPresenterProtocol {
    init(view: JobListViewProtocol, model: JobListModel)
    func viewDidLoad()
    func bookingButtonTapped()
    func didSelectJob(id: String)
    func didDeselectJob(id: String)
    func updateSearchController(searchBarText: String?)
}

final class JobListViewController: UIViewController {
        
    typealias Datasource = UICollectionViewDiffableDataSource<Section, SectionItem>
    typealias Snapshot   = NSDiffableDataSourceSnapshot<Section, SectionItem>
    typealias JobCellReg = UICollectionView.CellRegistration<JobCell, SectionItem>
    
    // MARK: - Property
    var presenter: JobListPresenterProtocol!
    private var dataSource: Datasource!
    private let searchController = UISearchController(searchResultsController: nil)
    private lazy var bookingButton = BookingButton(primaryAction: bookingAction)
    private lazy var backButtonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = R.Colors.viewBackground.ui.withAlphaComponent(0.9)
        return view
    }()
    private var bookingAction: UIAction {
        UIAction { [unowned self] _ in
            presenter.bookingButtonTapped()
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = R.Colors.collectionViewBackground.ui
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsMultipleSelection = true
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var layout: UICollectionViewLayout = {
        UICollectionViewCompositionalLayout { section, environment in
            let sectionType = self.dataSource.snapshot().sectionIdentifiers[section]
            
            switch sectionType {
            case .jobs:
                return NSCollectionLayoutSection.createListJobsLayout()
            }
        }
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupUI()
        setupSearchController()
        createDataSource()
        presenter.viewDidLoad()
    }
}

// MARK: - Private methods
private extension JobListViewController {
    
    func setupView() {
        view.backgroundColor = R.Colors.viewBackground.ui
        view.addSubviews(collectionView, backButtonView, bookingButton)
    }
    
    func setupUI() {
        bookingButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backButtonView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backButtonView.heightAnchor.constraint(equalToConstant: 100),
            
            bookingButton.topAnchor.constraint(equalTo: backButtonView.topAnchor, constant: 16),
            bookingButton.leadingAnchor.constraint(equalTo: backButtonView.leadingAnchor, constant: 16),
            bookingButton.trailingAnchor.constraint(equalTo: backButtonView.trailingAnchor, constant: -16),
            bookingButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        
        definesPresentationContext = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.titleView = searchController.searchBar
    }

    func createDataSource() {
        let cellRegistration = JobCellReg { cell, indexPath, item in
            if case let .jobs(job) = item {
                cell.configure(with: job)
            }
        }

        dataSource = Datasource(collectionView: collectionView,
                                cellProvider: cellRegistration.cellProvider)
    }
    
    func applySnapshot(
        data: SectionData,
        selectedPaths: [IndexPath],
        animatingDifferences: Bool = false,
        completion: (() -> Void)? = nil
    ) {
        var snapshot = Snapshot()
        //snapshot.deleteAllItems()
        snapshot.appendSections([data.key])
        snapshot.appendItems(data.values, toSection: data.key)
        self.dataSource.apply(snapshot, animatingDifferences: animatingDifferences, completion: completion)
        collectionView.select(selectedPaths, scrollPosition: [])
    }
}

// MARK: - JobListViewProtocol
extension JobListViewController: JobListViewProtocol {
    
    func updateButton(with title: String, isActive: Bool) {
        bookingButton.configure(with: title, isActive: isActive)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func updateCollection(with data: SectionData, selectedPaths: [IndexPath]) {
        applySnapshot(data: data, selectedPaths: selectedPaths, animatingDifferences: true)
    }
}

// MARK: - UICollectionViewDelegate
extension JobListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = dataSource.itemIdentifier(for: indexPath) {
            switch item {
            case .jobs(let job):
                presenter.didSelectJob(id: job.id)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let item = dataSource.itemIdentifier(for: indexPath) {
            switch item {
            case .jobs(let job):
                presenter.didDeselectJob(id: job.id)
            }
        }
    }
}

// MARK: - UISearchResultsUpdating
extension JobListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        presenter.updateSearchController(searchBarText: searchController.searchBar.text)
    }
}
