//
//  AppsSearchRouter.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import Foundation
import UIKit

protocol AppsSearchRouterProtocol: AnyObject {
    
    func toDetail(appId: Int)
}

final class AppsSearchRouter: AppsSearchRouterProtocol {
    
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func toDetail(appId: Int) {
        let detailVC = AppDetailBuilder.start(id: String(appId))
        self.view?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
