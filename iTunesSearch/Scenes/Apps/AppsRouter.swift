//
//  AppsRouter.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import Foundation
import UIKit

protocol AppsRouterProtocol: AnyObject {
    
    func toDetail(id: String)
}

final class AppsRouter: AppsRouterProtocol {
    
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func toDetail(id: String) {
        let detailVC = AppDetailBuilder.start(id: id)
        self.view?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
