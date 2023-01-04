//
//  AppDetailPresenter.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 4.01.2023.
//

import Foundation

protocol AppDetailPresenterProtocol: AnyObject {
    
    var app: AppResult? { get }
    
    func viewDidLoad()
}

protocol AppDetailInteractorOutputs: AnyObject {
    func beginRefreshing()
    func endRefreshing()
    func onError(message: String)
    func loadApp(app: AppResult)
}

final class AppDetailPresenter: AppDetailPresenterProtocol {
    
    private weak var view: AppDetailViewProtocol?
    private let router: AppDetailRouterProtocol
    private let interactor: AppDetailInteractorProtocol
    
    private(set) internal var app: AppResult?
    
    init(view: AppDetailViewProtocol, router: AppDetailRouterProtocol, interactor: AppDetailInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.interactor.delegate = self
    }
    
    func viewDidLoad() {
        self.view?.prepareCollectionView()
        self.interactor.getDetail()
    }
}

extension AppDetailPresenter: AppDetailInteractorOutputs {
 
    func beginRefreshing() {
        self.view?.beginRefreshing()
    }
    
    func endRefreshing() {
        self.view?.endRefreshing()
    }

    func onError(message: String) {
        self.view?.onError(message: message)
    }
    
    func loadApp(app: AppResult) {
        self.app = app
        self.view?.dataRefreshed()
    }
}
