//
//  AppsSearchRouter.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import Foundation
import UIKit

protocol AppsSearchRouterProtocol: AnyObject {
    
}

final class AppsSearchRouter: AppsSearchRouterProtocol {
    
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
}
