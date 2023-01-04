//
//  UIStackView+Extension.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 4.01.2023.
//

import Foundation
import UIKit.UIStackView

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], customSpacing: CGFloat = 0) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = customSpacing
    }
}
