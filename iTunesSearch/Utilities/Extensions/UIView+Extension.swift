//
//  UIView+Extensiona.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import Foundation
import UIKit

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?,
                leading: NSLayoutXAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                padding: UIEdgeInsets = .zero,
                size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top {
            self.topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading {
            self.leftAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let trailing {
            self.rightAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if let bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
        }
        
        if size.width != 0 {
            self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
}
