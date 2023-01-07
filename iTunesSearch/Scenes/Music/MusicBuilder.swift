//
//  MusicBuilder.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 6.01.2023.
//

import Foundation

final class MusicBuilder {
    
    static func start() -> MusicViewController {
        let view = MusicViewController()
        let router = MusicRouter(view: view)
        let interactor = MusicInteractor()
        let presenter = MusicPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        
        return view
    }
}
