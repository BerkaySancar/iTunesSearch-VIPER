//
//  AppsHeader.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import UIKit

final class AppsHeader: UICollectionReusableView {
    
    static let identifier = "AppsHeader"
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUIElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUIElements() {
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.anchor(top: self.topAnchor, leading: self.leftAnchor, trailing: self.rightAnchor, bottom: self.bottomAnchor)
        collectionView.register(AppsHeaderHorizontalCell.self, forCellWithReuseIdentifier: AppsHeaderHorizontalCell.identifier)
    }
}

extension AppsHeader: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsHeaderHorizontalCell.identifier, for: indexPath) as? AppsHeaderHorizontalCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width - 48, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 16, bottom: 0, right: 0)
    }
}
