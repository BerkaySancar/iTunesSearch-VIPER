//
//  TodayFullscreenCell.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 5.01.2023.
//

import UIKit

final class TodayFullscreenCell: UITableViewCell {
    
    static let identifier = "TodayFullscreenCell"
        
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
    
    private lazy var appName = UILabel(text: "AppName", font: .systemFont(ofSize: 16))
    
    private lazy var getButton: GetButton = {
        let button = GetButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.clipsToBounds = true
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let stackView = UIStackView(arrangedSubviews: [appImageView, appName, getButton], customSpacing: 8)
        contentView.addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leftAnchor, trailing: rightAnchor, bottom: bottomAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16))
        
        stackView.alignment = .center
    }
    
    internal func design(appGroup: FeedResult) {
        self.appImageView.sd_setImage(with: URL(string: appGroup.artworkUrl100))
        self.appName.text = appGroup.name
    }
}
