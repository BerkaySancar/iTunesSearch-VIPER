//
//  TodayCell.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 5.01.2023.
//

import UIKit

final class DailyListCell: UICollectionViewCell {
    
    static let identifier = "DailyListCell"
    
    private lazy var categoryLabel = UILabel(text: "Daily List", font: .boldSystemFont(ofSize: 20))
    
    private lazy var titleLabel = UILabel(text: "Apps", font: .boldSystemFont(ofSize: 32), numberOfLines: 2)
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    weak var delegate: DailyListCellDelegate?
    
    private var appGroup: [FeedResult] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 16
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.register(AppsRowCell.self, forCellWithReuseIdentifier: AppsRowCell.identifier)
        
        let stackView = VerticalStackView(arrangedSubviews: [categoryLabel,
                                                            titleLabel,
                                                            collectionView
                                                            ], spacing: 12)
        contentView.addSubview(stackView)
        stackView.anchor(top: topAnchor,
                         leading: leftAnchor,
                         trailing: rightAnchor,
                         bottom: bottomAnchor, padding: .init(top: 24, left: 24, bottom: -24, right: 24))
    }
    
    internal func design(appGroup: AppGroup) {
        self.appGroup = appGroup.feed.results
        self.titleLabel.text = appGroup.feed.title
    }
}

// MARK: - UICollectionView Delegate & Data Source
extension DailyListCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(4, appGroup.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsRowCell.identifier, for: indexPath) as? AppsRowCell else { return UICollectionViewCell() }
        cell.desing(app: appGroup[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.collectionView.frame.width, height: 64)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appId = appGroup[indexPath.row].id
        delegate?.selectedApp(id: appId)
    }
}
