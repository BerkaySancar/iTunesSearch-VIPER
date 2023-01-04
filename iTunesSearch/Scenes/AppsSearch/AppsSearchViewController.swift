//
//  AppsSearchViewController.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import UIKit

protocol AppsSearchViewProtocol: AnyObject {
    
    func prepareCollectionView()
    func prepareSearchController()
    func beginRefreshing()
    func endRefreshing()
    func dataRefreshed()
    func showApps(apps: [App])
    func onError(message: String)
}

final class AppsSearchViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private lazy var searchController: UISearchController = {
        let searchVC = UISearchController(searchResultsController: nil)
        return searchVC
    }()
    
    private lazy var searchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "Search something... 🔍"
        label.textAlignment = .center
        return label
    }()
    
    var presenter: AppsSearchPresenterProtocol!
    
    private var apps: [App] = []
    
// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

// MARK: - View Protocol
extension AppsSearchViewController: AppsSearchViewProtocol {
    
    func prepareCollectionView() {
        view.addSubview(collectionView)
        self.collectionView.anchor(top: self.view.topAnchor, leading: self.view.leftAnchor, trailing: self.view.rightAnchor, bottom: self.view.bottomAnchor)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundView = searchTermLabel
        self.collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: SearchResultCell.identifier)
    }
    
    func prepareSearchController() {
        definesPresentationContext = true
        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = true
        self.searchController.searchBar.delegate = self
    }
    
    func beginRefreshing() {
       
    }
    
    func endRefreshing() {

    }
    
    func dataRefreshed() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func showApps(apps: [App]) {
        DispatchQueue.main.async {
            self.apps = apps
        }
    }
    
    func onError(message: String) {
        DispatchQueue.main.async {
            self.showError(message: message)
        }
    }
}

// MARK: - Collection View Delegate & Data Source
extension AppsSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchTermLabel.isHidden = !apps.isEmpty
        return apps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCell.identifier, for: indexPath) as? SearchResultCell else { return UICollectionViewCell() }
        cell.design(model: self.apps[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let selectedID = self.apps[indexPath.row].trackId
        presenter.didTapCellItem(id: selectedID)
    }
}

// MARK: - Search Bar Delegate
extension AppsSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchTextDidChange(text: searchText)
    }
}
