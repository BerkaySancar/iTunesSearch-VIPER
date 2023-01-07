//
//  ReviewRowCell.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 4.01.2023.
//

import UIKit

final class ReviewRowCell: UICollectionViewCell {
    
    static let identifier = "ReviewRowCell"
    
    private lazy var reviewLabel = UILabel(text: "Review & Ratings", font: .boldSystemFont(ofSize: 20))
    
    private lazy var collectionView: UICollectionView = {
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
        return collectionView
    }()
    
    private var reviews: Reviews?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUiElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: Configure & Design UI
    private func configureUiElements() {
        addSubview(reviewLabel)
        reviewLabel.anchor(top: contentView.topAnchor, leading: contentView.leftAnchor, trailing: contentView.rightAnchor, bottom: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 0))
        
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.anchor(top: reviewLabel.bottomAnchor, leading: leftAnchor, trailing: rightAnchor, bottom: bottomAnchor, padding: .init(top: 20, left: 16, bottom: 0, right: 0))
        collectionView.register(ReviewsHorizontalCell.self, forCellWithReuseIdentifier: ReviewsHorizontalCell.identifier)
    }
    
    internal func design(reviews: Reviews) {
        self.reviews = reviews
        self.collectionView.reloadData()
    }
}

// MARK: - UICollectionView Delegate & Data Source
extension ReviewRowCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews?.feed.entry.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewsHorizontalCell.identifier, for: indexPath) as? ReviewsHorizontalCell else { return UICollectionViewCell() }
        cell.backgroundColor = .systemGray6
        cell.layer.cornerRadius = 8
        if let entry = reviews?.feed.entry[indexPath.item] {
            cell.design(entry: entry)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width - 48 , height: collectionView.frame.height)
    }
}
