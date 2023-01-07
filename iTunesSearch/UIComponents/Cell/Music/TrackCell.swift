//
//  TrackCell.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 6.01.2023.
//

import UIKit

final class TrackCell: UICollectionViewCell {
    
    static let identifier = "TrackCell"
    
    private lazy var musicImageView = UIImageView(cornerRadius: 16)
    
    private lazy var nameLabel = UILabel(text: "Track name", font: .boldSystemFont(ofSize: 18))
    
    private lazy var subtitleLabel = UILabel(text: "Subtitle", font: .systemFont(ofSize: 16), numberOfLines: 2)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        musicImageView.translatesAutoresizingMaskIntoConstraints = false
        musicImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        musicImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        musicImageView.backgroundColor = .gray
        let stackView = UIStackView(arrangedSubviews: [musicImageView,
                                                       VerticalStackView(arrangedSubviews: [nameLabel,
                                                                                            subtitleLabel], spacing: 4)],
                                                                                            customSpacing: 16)
        
        contentView.addSubview(stackView)
        stackView.alignment = .center
        stackView.anchor(top: contentView.topAnchor,
                         leading: contentView.leftAnchor,
                         trailing: contentView.rightAnchor,
                         bottom: contentView.bottomAnchor, padding: .init(top: 16,
                                                                          left: 16,
                                                                          bottom: 16, right: 16))
    }
    
    internal func design() {
        
    }
}
