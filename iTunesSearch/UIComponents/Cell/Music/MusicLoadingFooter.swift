//
//  MusicLoadingFooter.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 7.01.2023.
//

import UIKit

final class MusicLoadingFooter: UICollectionReusableView {
        
    static let identifier = "MusicLoadingFooter"
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView()
        aiv.color = .label
        aiv.startAnimating()
        return aiv
    }()
    
    private lazy var loadingLabel = UILabel(text: "Loading...", font: .systemFont(ofSize: 16))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let stackView = VerticalStackView(arrangedSubviews: [activityIndicatorView, loadingLabel])
        addSubview(stackView)
        stackView.anchor(top: topAnchor,
                         leading: leftAnchor, trailing: rightAnchor,
                         bottom: bottomAnchor, padding: .init(top: 32, left: 0, bottom: 0, right: 0))
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    
        
        stackView.alignment = .center
    }
}
