//
//  PreviewCell.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 4.01.2023.
//

import UIKit

final class PreviewCell: UICollectionViewCell {
    
    static let identifier = "PreviewCell"
    
    private var app: SearchResult?
    
    private lazy var previewLabel = UILabel(text: "Preview", font: .boldSystemFont(ofSize: 20))
    
    private lazy var collectionView: UICollectionView = {
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUiElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Configure & Design UI
    private func configureUiElements() {
        addSubview(previewLabel)
        self.previewLabel.anchor(top: topAnchor, leading: leftAnchor, trailing: rightAnchor, bottom: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 0))
        
        contentView.addSubview(collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.anchor(top: previewLabel.bottomAnchor, leading: leftAnchor, trailing: rightAnchor, bottom: bottomAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 0))
        self.collectionView.register(PreviewScreenshotsCell.self, forCellWithReuseIdentifier: PreviewScreenshotsCell.identifier)
    }
    
    internal func design(app: SearchResult) {
        self.app = app
        self.collectionView.reloadData()
    }
}

// MARK: - UICollectionView Delegate & Data Source
extension PreviewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.app?.results.first?.screenshotUrls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PreviewScreenshotsCell.identifier, for: indexPath) as? PreviewScreenshotsCell else { return UICollectionViewCell() }
        cell.design(screenShot: self.app?.results.first?.screenshotUrls?[indexPath.item] ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 250, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select")
    }
}
