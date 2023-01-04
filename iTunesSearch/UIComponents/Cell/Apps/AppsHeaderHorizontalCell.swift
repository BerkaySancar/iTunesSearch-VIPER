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
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var socialImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUIElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Configure & Design UI
    private func configureUIElements() {
        let stackView = VerticalStackView(arrangedSubviews: [companyLabel,
                                                             titleLabel,
                                                             socialImageView
                                                             ], spacing: 12)
        
        addSubview(stackView)
        stackView.anchor(top: self.topAnchor, leading: self.leftAnchor, trailing: self.rightAnchor, bottom: self.bottomAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    internal func design(app: SocialApp) {
        self.titleLabel.text = app.tagline
        self.companyLabel.text = app.name
        self.socialImageView.sd_setImage(with: URL(string: app.imageUrl))
    }
}
