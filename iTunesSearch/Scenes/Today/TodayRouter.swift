//
//  TodayRouter.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import Foundation
import UIKit

protocol TodayRouterProtocol: AnyObject {
    
    func toDetail(id: String)
}

final class TodayRouter: TodayRouterProtocol {
    
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func toDetail(id: String) {
        let detailVC = AppDetailBuilder.start(id: id)
        view?.present(detailVC, animated: true)
    }
}
