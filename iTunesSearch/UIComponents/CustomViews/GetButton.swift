//
//  GetButton.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import UIKit

final class GetButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.setTitle("GET", for: .normal)
        self.setTitleColor(.systemBlue, for: .normal)
        self.titleLabel?.font = .boldSystemFont(ofSize: 14)
        self.backgroundColor = .systemGray5
        self.widthAnchor.constraint(equalToConstant: 80).isActive = true
        self.heightAnchor.constraint(equalToConstant: 32).isActive = true
        self.layer.cornerRadius = 16
    }
}
