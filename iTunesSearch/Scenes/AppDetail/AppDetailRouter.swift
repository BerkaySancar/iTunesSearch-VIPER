//
//  AppDetailRouter.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 4.01.2023.
//

import Foundation
import UIKit

protocol AppDetailRouterProtocol: AnyObject {
    
}

final class AppDetailRouter: AppDetailRouterProtocol {
    
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
}
