//
//  AppDetailBuilder.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 4.01.2023.
//

import Foundation

final class AppDetailBuilder {
    
    static func start(id: String) -> AppDetailViewController {
        let view = AppDetailViewController()
        let router = AppDetailRouter(view: view)
        let interactor = AppDetailInteractor(id: id)
        let presenter = AppDetailPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        return view
    }
}
