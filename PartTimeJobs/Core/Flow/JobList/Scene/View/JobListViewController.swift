//
//  JobListViewController.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 02.11.2023.
//

import UIKit

final class JobListViewController: UIViewController {
    
    enum LocalConstants {
        // Адаптивная настройка высоты footer view с кнопкой с учетом наличия/отсутствия safeArea
        static let heightFootView: CGFloat = 80
    }
    
    typealias Datasource = UICollectionViewDiffableDataSource<Section, SectionItem>
    typealias Snapshot   = NSDiffableDataSourceSnapshot<Section, SectionItem>
    typealias JobCellReg = UICollectionView.CellRegistration<JobCell, SectionItem>
    
    // MARK: - Property
    var presenter: JobListPresenterProtocol!
    private var dataSource: Datasource!
    private let searchController = UISearchController(searchResultsController: nil)
    private lazy var bookingButton = BookingButton(primaryAction: bookingAction)
    private let footerView = UIView()
    private var bookingAction: UIAction {
        UIAction { [unowned self] _ in
            presenter.bookingButtonTapped()
        }
    }
    
    var bottomSafeAreaInset: CGFloat {
        let window = UIWindow.keyWindow
        return window?.safeAreaInsets.bottom ?? 0.0
    }
    
    var contentInsets: UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: LocalConstants.heightFootView, right: 0)
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = R.Colors.collectionViewBackground.ui
        collectionView.contentInset = contentInsets
        collectionView.showsVerticalScrollIndicator = false
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
        setupViews()
        setupLayout()
        setupSearchController()
        createDataSource()
        setupObservers()
        presenter.viewDidLoad()
    }
}

// MARK: - Private methods
private extension JobListViewController {
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubviews(collectionView, footerView, bookingButton)
        footerView.backgroundColor = R.Colors.listItemBackground.ui.withAlphaComponent(0.9)
    }
    
    func setupLayout() {
        footerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: LocalConstants.heightFootView + bottomSafeAreaInset),
            
            bookingButton.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 16),
            bookingButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 16),
            bookingButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -16),
            bookingButton.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -16 - bottomSafeAreaInset)
        ])
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.keyboardType = .default
        searchController.searchBar.searchTextField.returnKeyType = .done
        definesPresentationContext = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.titleView = searchController.searchBar
    }
    
    func createDataSource() {
        let cellRegistration = JobCellReg { cell, indexPath, item in
            switch item {
            case .jobs(let item):
                cell.configure(with: item)
            }
        }
        
        dataSource = Datasource(collectionView: collectionView,
                                cellProvider: cellRegistration.cellProvider)
    }
    
    func setupObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height - bottomSafeAreaInset, right: 0)
        collectionView.contentInset = contentInsets
        collectionView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        collectionView.contentInset = self.contentInsets
        collectionView.scrollIndicatorInsets = self.contentInsets
    }
    
    func applySnapshot(
        data: SectionData,
        animatingDifferences: Bool = false,
        completion: (() -> Void)? = nil
    ) {
        var snapshot = Snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections([data.key])
        snapshot.appendItems(data.values, toSection: data.key)
        self.dataSource.apply(snapshot, animatingDifferences: animatingDifferences, completion: completion)
        collectionView.select(data.selectedPath)
    }
}

// MARK: - JobListViewProtocol
extension JobListViewController: JobListViewProtocol {
    
    func updateButton(with title: String?, isActive: Bool) {
        bookingButton.configure(with: title, isActive: isActive)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func updateCollection(with data: SectionData) {
        applySnapshot(data: data, animatingDifferences: true)
    }
}

// MARK: - UICollectionViewDelegate
extension JobListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = dataSource.itemIdentifier(for: indexPath) {
            switch item {
            case .jobs(let job):
                presenter.didSelectJob(job)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let item = dataSource.itemIdentifier(for: indexPath) {
            switch item {
            case .jobs(let job):
                presenter.didDeselectJob(job)
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

// MARK: - UISearchBarDelegate
extension JobListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.dismiss(animated: true)
    }
}
