//
//  AppsGroupCollectionViewCell.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import UIKit

final class AppsGroupCell: UICollectionViewCell {
    
    static let identifier = "AppsGroupCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "App Section"
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
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
        configureTitleLabel()
        configureCollectionView()
    }
    
    private func configureTitleLabel() {
        contentView.addSubview(titleLabel)
        self.titleLabel.anchor(top: self.topAnchor, leading: self.leftAnchor, trailing: self.rightAnchor, bottom: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
    }
    
    private func configureCollectionView() {
        contentView.addSubview(collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(AppsRowCell.self, forCellWithReuseIdentifier: AppsRowCell.identifier)
        self.collectionView.anchor(top: titleLabel.bottomAnchor, leading: self.leftAnchor, trailing: self.rightAnchor, bottom: self.bottomAnchor)
    }
}

extension AppsGroupCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 13
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsRowCell.identifier, for: indexPath) as? AppsRowCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.frame.height - 2 * 12 - 2 * 10) / 3
        return .init(width: collectionView.frame.width - 48, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 12, left: 16, bottom: 12, right: 16)
    }
    
}
