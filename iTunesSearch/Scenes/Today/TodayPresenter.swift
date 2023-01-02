//
//  TodayPresenter.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import Foundation

protocol TodayPresenterProtocol: AnyObject {
    
}

protocol TodayInteractorOutputs: AnyObject {
    
}

final class TodayPresenter: TodayPresenterProtocol {
    
    private weak var view: TodayViewProtocol?
    private let router: TodayRouterProtocol
    private let interactor: TodayInteractorProtocol
    
    init(view: TodayViewProtocol, router: TodayRouterProtocol, interactor: TodayInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.interactor.delegate = self
    }
}

extension TodayPresenter: TodayInteractorOutputs {
    
}
