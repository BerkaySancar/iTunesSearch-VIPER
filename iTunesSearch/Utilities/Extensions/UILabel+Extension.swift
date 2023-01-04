//
//  UILabel+Extension.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 4.01.2023.
//

import Foundation
import UIKit.UILabel

extension UILabel {
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
}

