//
//  AppSearchPresenter.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import Foundation

protocol AppsSearchPresenterProtocol: AnyObject {
    
    func viewDidLoad()
    func searchTextDidChange(text: String)
    func didTapCellItem(id: Int)
}

protocol AppsSearchInteractorOutputs: AnyObject {
    func beginRefreshing()
    func endRefreshing()
    func dataRefreshed()
    func onError(message: String)
    func showApps(apps: [ResultModel])
}

final class AppsSearchPresenter: AppsSearchPresenterProtocol {
    
    private weak var view: AppsSearchViewProtocol?
    private let router: AppsSearchRouterProtocol
    private let interactor: AppsSearchInteractorProtocol
    
    init(view: AppsSearchViewProtocol, router: AppsSearchRouterProtocol, interactor: AppsSearchInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.interactor.delegate = self
    }
    
    func viewDidLoad() {
        self.view?.prepareCollectionView()
        self.view?.prepareSearchController()
    }
    
    func searchTextDidChange(text: String) {
        self.interactor.getData(searchTerm: text)
    }
    
    func didTapCellItem(id: Int) {
        self.router.toDetail(appId: id)
    }
}

extension AppsSearchPresenter: AppsSearchInteractorOutputs {
    
    func beginRefreshing() {
        self.view?.beginRefreshing()
    }
    
    func endRefreshing() {
        self.view?.endRefreshing()
    }
    
    func dataRefreshed() {
        self.view?.dataRefreshed()
    }
    
    func showApps(apps: [ResultModel]) {
        self.view?.showApps(apps: apps)
    }
    
    func onError(message: String) {
        self.view?.onError(message: message)
    }
}
