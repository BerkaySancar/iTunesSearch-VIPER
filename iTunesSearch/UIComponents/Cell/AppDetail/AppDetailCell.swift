//
//  AppDetailCell.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 4.01.2023.
//

import UIKit

final class AppDetailCell: UICollectionViewCell {
    
    static let identifier = "AppDetailCell"

    private lazy var iconImageView = UIImageView(cornerRadius: 8)
    
    private lazy var nameLabel = UILabel(text: "App name", font: .boldSystemFont(ofSize: 24), numberOfLines: 2)
    
    private lazy var priceButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private lazy var whatsNewLabel = UILabel(text: "whats new", font: .boldSystemFont(ofSize: 20))
    
    private lazy var releaseNotesLabel = UILabel(text: "Release notes", font: .systemFont(ofSize: 18), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUiElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Configure & Design UI Elements
    private func configureUiElements() {
        iconImageView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        priceButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        priceButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [
                iconImageView,
                VerticalStackView(arrangedSubviews: [
                    nameLabel,
                    UIStackView(arrangedSubviews: [priceButton, UIView()]),
                    UIView()
                ], spacing: 12)], customSpacing: 20),
                whatsNewLabel,
                releaseNotesLabel
        ], spacing: 16)
        
        addSubview(stackView)
        
        stackView.anchor(top: topAnchor,
                         leading: leftAnchor,
                         trailing: rightAnchor,
                         bottom: bottomAnchor,
                         padding: .init(top: 20, left: 20, bottom: 0, right: 20))
    }
    
    internal func design(app: AppResult) {
        self.iconImageView.sd_setImage(with: URL(string: app.results.first?.artworkUrl100 ?? ""))
        self.nameLabel.text = app.results.first?.trackName
        self.priceButton.setTitle(app.results.first?.formattedPrice, for: .normal)
        self.releaseNotesLabel.text = app.results.first?.releaseNotes
        self.whatsNewLabel.text = app.results.first?.description
    }
}
