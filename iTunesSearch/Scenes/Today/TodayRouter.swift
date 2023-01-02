//
//  TodayRouter.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import Foundation
import UIKit

protocol TodayRouterProtocol: AnyObject {
    
}

final class TodayRouter: TodayRouterProtocol {
    
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
}
