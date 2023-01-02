//
//  SearchResultCell.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import UIKit
import SDWebImage

final class SearchResultCell: UICollectionViewCell {
    
    static let identifier = "SearchResultCell"
    
    private let appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        return label
    }()
    
    private let getButton: UIButton = {
        let button = UIButton()
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = .systemGray5
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "category"
        return label
    }()
    
    private let ratingsLabel: UILabel = {
        let label = UILabel()
        label.text = "rating"
        return label
    }()
    
    private lazy var screenshot1ImageView = self.createScreenshotImageView()
    private lazy var screenshot2ImageView = self.createScreenshotImageView()
    private lazy var screenshot3ImageView = self.createScreenshotImageView()
    
    private func createScreenshotImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 0.5
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUIElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUIElements() {
        let labelsStackView = VerticalStackView(arrangedSubviews: [nameLabel, categoryLabel, ratingsLabel])
        
        let topInfoStackView = UIStackView(arrangedSubviews: [appIconImageView, labelsStackView, getButton])
        topInfoStackView.spacing = 12
        topInfoStackView.alignment = .center
        
        let screenshotsStackView = UIStackView(arrangedSubviews: [screenshot1ImageView, screenshot2ImageView, screenshot3ImageView])
        screenshotsStackView.spacing = 12
        screenshotsStackView.distribution = .fillEqually
        
        let overallStackView = VerticalStackView(arrangedSubviews: [topInfoStackView, screenshotsStackView], spacing: 16)
        
        addSubview(overallStackView)
        overallStackView.anchor(top: self.topAnchor, leading: self.leftAnchor, trailing: self.rightAnchor, bottom: self.bottomAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    func design(model: App) {
        self.nameLabel.text = model.trackName
        self.ratingsLabel.text = "\(model.averageUserRating ?? 0.0)"
        self.categoryLabel.text = model.primaryGenreName
        let url = URL(string: model.artworkUrl100)
        self.appIconImageView.sd_setImage(with: url)
        self.screenshot1ImageView.sd_setImage(with: URL(string: model.screenshotUrls[0]))
        if model.screenshotUrls.count > 1 {
            self.screenshot2ImageView.sd_setImage(with: URL(string: model.screenshotUrls[1]))
        }
        if model.screenshotUrls.count > 2 {
            self.screenshot3ImageView.sd_setImage(with: URL(string: model.screenshotUrls[2]))
        }
    }
}
