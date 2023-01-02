//
//  AppsViewController.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import UIKit

protocol AppsViewProtocol: AnyObject {
    
    func prepareCollectionView()
}

final class AppsViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        return collectionView
    }()
    
    var presenter: AppsPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension AppsViewController: AppsViewProtocol {
    
    func prepareCollectionView() {
        view.addSubview(collectionView)
        self.collectionView.anchor(top: self.view.topAnchor, leading: self.view.leftAnchor, trailing: self.view.rightAnchor, bottom: self.view.bottomAnchor)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: AppsGroupCell.identifier)
        self.collectionView.register(AppsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AppsHeader.identifier)
    }
}

extension AppsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AppsHeader.identifier, for: indexPath) as? AppsHeader else { return UICollectionReusableView() }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.height, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsGroupCell.identifier, for: indexPath) as? AppsGroupCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}
