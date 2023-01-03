//
//  AppsPresenter.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import Foundation

protocol AppsPresenterProtocol: AnyObject {
    
    func viewDidLoad()
}

protocol AppsInteractorOutputs: AnyObject {
    func beginRefreshing()
    func endRefreshing()
    func dataRefreshed()
    func onError(message: String)
    func showData(appGroup: [AppGroup])
    func showSocialApps(socialApps: [SocialApp])
    
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
    
    func viewDidLoad() {
        self.view?.prepareCollectionView()
        self.view?.prepareActivityIndicatorView()
        self.interactor.getGroupApps()
        self.interactor.getSocialApps()
    }
}

extension AppsPresenter: AppsInteractorOutputs {
    
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
        self.view?.showApps(appGroup: appGroup)
    }
    
    func showSocialApps(socialApps: [SocialApp]) {
        self.view?.showSocialApps(socialApps: socialApps)
    }
}
