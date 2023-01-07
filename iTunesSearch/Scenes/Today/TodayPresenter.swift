//
//  TodayPresenter.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import Foundation

protocol TodayPresenterProtocol: AnyObject {
    
    func viewDidLoad()
    func didSelectApp(id: String)
}

protocol TodayInteractorOutputs: AnyObject {
    
    func beginRefreshing()
    func endRefreshing()
    func dataRefreshed()
    func onError(message: String)
    func showData(appGroup: [AppGroup])
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
    
    func viewDidLoad() {
        self.view?.prepareCollectionView()
        self.view?.prepareActivityIndicatorView()
        self.interactor.getGroupApps()
    }
    
    func didSelectApp(id: String) {
        self.router.toDetail(id: id)
    }
}

extension TodayPresenter: TodayInteractorOutputs {
    
    func beginRefreshing() {
        self.view?.beginRefreshing()
    }
    
    func endRefreshing() {
        self.view?.endRefreshing()
    }
    
    func dataRefreshed() {
        self.view?.dataRefreshed()
    }
    
    func onError(message: String) {
        self.view?.onError(message: message)
    }
    
    func showData(appGroup: [AppGroup]) {
        self.view?.showData(appGroup: appGroup)
    }
}
