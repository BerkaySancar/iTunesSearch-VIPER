//
//  TodayCell.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 5.01.2023.
//

import UIKit

final class TodayCell: UICollectionViewCell {
    
    static let identifier = "TodayCell"
    
    private lazy var categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
    
    private lazy var titleLabel = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 29))
    
    private lazy var appImageView: UIImageView = {
        let image = UIImage(systemName: "house.fill")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 240).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 240).isActive = true
        return imageView
    }()
    
    private lazy var descriptionLabel = UILabel(text: "All the tools and apps........ All the tools and apps........All the tools and apps........All the tools and apps........All the tools and apps........All the tools and apps........All the tools and apps........All the tools and apps........All the tools and apps........All the tools and apps........All the tools and apps........All the tools and apps........All the tools and apps........All the tools and apps........All the tools and apps........All the tools and apps........All the tools and apps........All the tools and apps........All the tools and apps........",
                                                font: .systemFont(ofSize: 16),
                                                numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 16
        
        appImageView.contentMode = .scaleAspectFill
        
        let stackView = VerticalStackView(arrangedSubviews: [categoryLabel,
                                                            titleLabel,
                                                            appImageView,
                                                            descriptionLabel], spacing: 8)
        contentView.addSubview(stackView)
        stackView.anchor(top: topAnchor,
                         leading: leftAnchor,
                         trailing: rightAnchor,
                         bottom: bottomAnchor, padding: .init(top: 24, left: 24, bottom: -24, right: 24))
    }
}
