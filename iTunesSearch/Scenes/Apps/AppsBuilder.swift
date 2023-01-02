//
//  AppsBuilder.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import Foundation

final class AppsBuilder {
    
    static func start() -> AppsViewController {
        let view = AppsViewController()
        let router = AppsRouter(view: view)
        let inteactor = AppsInteractor()
        let presenter = AppsPresenter(view: view, router: router, interactor: inteactor)
        
        view.presenter = presenter
        
        return view
    }
}
