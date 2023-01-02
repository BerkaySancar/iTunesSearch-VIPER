//
//  AppsPresenter.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import Foundation

protocol AppsPresenterProtocol: AnyObject {
    
}

protocol AppsInteractorOutputs: AnyObject {
    
}

final class AppsPresenter: AppsPresenterProtocol {
    
    private weak var view: AppsViewProtocol?
    private let router: AppsRouterProtocol
    private let interactor: AppsInteractorProtocol
    
    init(view: AppsViewProtocol, router: AppsRouterProtocol, interactor: AppsInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.interactor.delegate = self
    }
    
}

extension AppsPresenter: AppsInteractorOutputs {
    
}
