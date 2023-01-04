//
//  AppDetailViewController.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 4.01.2023.
//

import UIKit

protocol AppDetailViewProtocol: AnyObject {
    func prepareCollectionView()
    func beginRefreshing()
    func endRefreshing()
    func dataRefreshed()
    func onError(message: String)
}

final class AppDetailViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    var presenter: AppDetailPresenterProtocol!

// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        self.navigationItem.largeTitleDisplayMode = .never
        presenter.viewDidLoad()
    }
}

// MARK: - View Protocol
extension AppDetailViewController: AppDetailViewProtocol {
    
    func prepareCollectionView() {
        view.addSubview(self.collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: AppDetailCell.identifier)
        self.collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: PreviewCell.identifier)
        self.collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leftAnchor, trailing: view.rightAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor)
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
    
    func onError(message: String) {
        self.showError(message: message)
    }
}

// MARK: - UICollectionView Delegate & DataSource
extension AppDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppDetailCell.identifier, for: indexPath) as? AppDetailCell else { return UICollectionViewCell() }
            if let app = presenter.app {
                cell.design(app: app)
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PreviewCell.identifier, for: indexPath) as? PreviewCell else { return UICollectionViewCell() }
            if let app = presenter.app {
                cell.design(app: app)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            // Dynamic size for cell
            let dummyCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            if let app = presenter.app {
                dummyCell.design(app: app)
                dummyCell.layoutIfNeeded()
            }
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
            // Dynamic size for cell
            
            return CGSize(width: view.frame.width, height: estimatedSize.height)
        } else {
            return .init(width: view.frame.width, height: 500)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
}
