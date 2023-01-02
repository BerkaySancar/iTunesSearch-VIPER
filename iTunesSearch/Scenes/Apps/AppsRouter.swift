//
//  AppsRouter.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import Foundation
import UIKit

protocol AppsRouterProtocol: AnyObject {
    
}

final class AppsRouter: AppsRouterProtocol {
    
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
}
