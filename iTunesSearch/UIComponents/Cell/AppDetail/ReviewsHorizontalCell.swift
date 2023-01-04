//
//  ReviewsHorizontalCell.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 4.01.2023.
//

import UIKit

final class ReviewsHorizontalCell: UICollectionViewCell {
    
    static let identifier = "ReviewsHorizontalCell"
    
    private lazy var titleLabel = UILabel(text: "Title", font: .boldSystemFont(ofSize: 18))
    
    private lazy var authorLabel = UILabel(text: "Author", font: .systemFont(ofSize: 18))

    private lazy var starsStackView: UIStackView = {
        var arrangedSubviews = [UIView]()
        (0..<5).forEach( { _ in
            let imageView = UIImageView(image: .init(systemName: "star.fill"))
            imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
            imageView.tintColor = .systemYellow
            arrangedSubviews.append(imageView)
        })
        
        arrangedSubviews.append(UIView())
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        return stackView
    }()
    
    private lazy var bodyLabel = UILabel(text: "", font: .systemFont(ofSize: 16), numberOfLines: 6)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUiElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Configure & Design UI
    private func configureUiElements() {
        authorLabel.textAlignment = .right
        titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal) //author names never cropped
        
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [titleLabel, authorLabel], customSpacing: 8),
            starsStackView,
            bodyLabel], spacing: 12)
        
        contentView.addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leftAnchor, trailing: rightAnchor, bottom: nil, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
    }
    
    internal func design(entry: Entry) {
        self.authorLabel.text = entry.author.name.label
        self.titleLabel.text = entry.title.label
        self.bodyLabel.text = entry.content.label
        
        for (index, view) in starsStackView.arrangedSubviews.enumerated() {
            if let ratingInt = Int(entry.rating.label) {
                view.alpha = index >= ratingInt ? 0 : 1
            }
        }
    }
}
