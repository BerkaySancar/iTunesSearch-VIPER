//
//  PreviewScreenshotsCell.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 4.01.2023.
//

import UIKit

final class PreviewScreenshotsCell: UICollectionViewCell {
    
    static let identifier = "PreviewScreenshotsCell"
    
    private lazy var screenshotImageView = UIImageView(cornerRadius: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUiElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUiElements() {
        addSubview(screenshotImageView)
        screenshotImageView.anchor(top: contentView.topAnchor, leading: leftAnchor, trailing: rightAnchor, bottom: contentView.bottomAnchor)
    }
    
    internal func design(screenShot: String) {
        self.screenshotImageView.sd_setImage(with: URL(string: screenShot))
    }
}
