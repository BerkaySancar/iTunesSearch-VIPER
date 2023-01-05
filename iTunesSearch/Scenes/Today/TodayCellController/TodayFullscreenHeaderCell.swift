//
//  TodayFullscreenHeaderCell.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 5.01.2023.
//

import UIKit

final class TodayFullscreenHeaderCell: UITableViewCell {
    
    static let identifier = "TodayFullscreenHeaderCell"
    
    private let todayCell = TodayCell()
    
    internal let closeButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "x.circle.fill")
        button.setImage(image, for: .normal)
        button.tintColor = .systemBlue
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(todayCell)
        todayCell.anchor(top: topAnchor, leading: leftAnchor, trailing: rightAnchor, bottom: bottomAnchor)
        
        contentView.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.anchor(top: topAnchor, leading: nil, trailing: rightAnchor, bottom: nil)
        closeButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
