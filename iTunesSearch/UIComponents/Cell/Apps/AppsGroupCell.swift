//
//  AppsGroupCollectionViewCell.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import UIKit

protocol AppsGroupCellDelegate: AnyObject {
    func didTapCellItem(item: FeedResult)
}

final class AppsGroupCell: UICollectionViewCell {
    
    static let identifier = "AppsGroupCell"
    
    weak var delegate: AppsGroupCellDelegate?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
        collectionView.contentInset = .init(top: 12, left: 16, bottom: 12, right: 16)
        return collectionView
    }()
    
    private var apps: [FeedResult] = []
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUIElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Configure & Design UI
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
    
    internal func design(appGroup: AppGroup) {
        self.titleLabel.text = appGroup.feed.title
        self.apps = appGroup.feed.results
        self.collectionView.reloadData()
    }
}

// MARK: - CollectionView Delegate & DataSource
extension AppsGroupCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsRowCell.identifier, for: indexPath) as? AppsRowCell else { return UICollectionViewCell() }
        cell.desing(app: self.apps[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.frame.height - 2 * 12 - 2 * 10) / 3.5
        return .init(width: collectionView.frame.width - 48, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = apps[indexPath.row]
        self.delegate?.didTapCellItem(item: item)
    }
}
