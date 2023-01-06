//
//  AppsViewController.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import UIKit

protocol AppsViewProtocol: AnyObject {
    
    func prepareCollectionView()
    func prepareActivityIndicatorView()
    func beginRefreshing()
    func endRefreshing()
    func dataRefreshed()
    func onError(message: String)
    func showApps(appGroup: [AppGroup])
    func showSocialApps(socialApps: [SocialApp])
}

final class AppsViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        return collectionView
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.hidesWhenStopped = true
        aiv.color = .label
        return aiv
    }()
    
    internal var presenter: AppsPresenterProtocol!
    
    private var appGroup: [AppGroup] = []
    private var socialApps: [SocialApp] = []
   
// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

// MARK: - Apps View Protocol
extension AppsViewController: AppsViewProtocol {
    func prepareCollectionView() {
        view.addSubview(collectionView)
        self.collectionView.anchor(top: self.view.topAnchor, leading: self.view.leftAnchor, trailing: self.view.rightAnchor, bottom: self.view.bottomAnchor)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: AppsGroupCell.identifier)
        self.collectionView.register(AppsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AppsHeader.identifier)
    }
    
    func prepareActivityIndicatorView() {
        view.addSubview(activityIndicatorView)
        activityIndicatorView.anchor(top: view.topAnchor, leading: view.leftAnchor, trailing: view.rightAnchor, bottom: view.bottomAnchor)
    }
    
    func beginRefreshing() {
        DispatchQueue.main.async {
            self.activityIndicatorView.startAnimating()
        }
    }
    
    func endRefreshing() {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    func dataRefreshed() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func onError(message: String) {
        DispatchQueue.main.async {
            self.showError(message: message)
        }
    }
    
    func showApps(appGroup: [AppGroup]) {
        self.appGroup = appGroup
    }
    
    func showSocialApps(socialApps: [SocialApp]) {
        self.socialApps = socialApps
    }
}

// MARK: - CollectionView Delegate & Data Source
extension AppsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
// MARK: header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AppsHeader.identifier, for: indexPath) as? AppsHeader else { return UICollectionReusableView() }
        header.design(socialApps: socialApps)
        return header
    }
    
// MARK: - layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.height, height: 300)
    }
    
// MARK: - number of items in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroup.count
    }
    
// MARK: - cell for item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsGroupCell.identifier, for: indexPath) as? AppsGroupCell else { return UICollectionViewCell() }
        let group = appGroup[indexPath.row]
        cell.design(appGroup: group)
        cell.delegate = self
        return cell
    }
    
// MARK: - size for item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 300)
    }
    
// MARK: - inset for section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - App Groups Cell Delegate
extension AppsViewController: AppsGroupCellDelegate {
    func didTapCellItem(item: FeedResult) {
        presenter.didTapCellItem(item: item)
    }
}
