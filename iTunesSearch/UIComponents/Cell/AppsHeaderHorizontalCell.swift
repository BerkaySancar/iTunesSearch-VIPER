//
//  AppsHeaderHorizontalCell.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import UIKit

final class AppsHeaderHorizontalCell: UICollectionViewCell {
    
    static let identifier = "AppsHeaderHorizontalCell"
    
    private lazy var companyLabel: UILabel = {
        let label = UILabel()
        label.text = "facebook"
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Keeping up friends.........."
        label.font = .systemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUIElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUIElements() {
        let stackView = VerticalStackView(arrangedSubviews: [companyLabel,
                                                             titleLabel,
                                                             cellImageView
                                                             ], spacing: 12)
        
        addSubview(stackView)
        stackView.anchor(top: self.topAnchor, leading: self.leftAnchor, trailing: self.rightAnchor, bottom: self.bottomAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
    }
}
