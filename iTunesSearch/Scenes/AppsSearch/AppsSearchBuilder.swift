//
//  AppsSearchBuilder.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import Foundation

final class AppsSearchBuilder {
    
    static func start() -> AppsSearchViewController {
        let view = AppsSearchViewController()
        let router = AppsSearchRouter(view: view)
        let interactor = AppsSearchInteractor()
        let presenter = AppsSearchPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        
        return view
    }
}
