//
//  AppsHorizontalCell.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import UIKit
import SDWebImage

final class AppsRowCell: UICollectionViewCell {
    
    static let identifier = "AppsRowCell"
    
    private lazy var appImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        return imageView
    }()
    
    private lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var companyNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var getButton = GetButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUIElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Configure & Design UI
    private func configureUIElements() {
        let stackView = UIStackView(arrangedSubviews: [appImageView,
                                                       VerticalStackView(arrangedSubviews: [appNameLabel, companyNameLabel]),
                                                       getButton])
        
        stackView.spacing = 16
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.anchor(top: self.topAnchor, leading: self.leftAnchor, trailing: self.rightAnchor, bottom: self.bottomAnchor)
    }
    
    internal func desing(app: FeedResult) {
        self.appNameLabel.text = app.name
        self.companyNameLabel.text = app.artistName
        self.appImageView.sd_setImage(with: URL(string: app.artworkUrl100))
    }
}
