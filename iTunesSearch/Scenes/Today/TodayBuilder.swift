//
//  TodayBuilder.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import Foundation

final class TodayBuilder {
    
    static func start() -> TodayViewController {
        let view = TodayViewController()
        let router = TodayRouter(view: view)
        let interactor = TodayInteractor()
        let presenter = TodayPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter

        return view
    }
}
