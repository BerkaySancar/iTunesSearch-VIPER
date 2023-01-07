//
//  AppDetailPresenter.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 4.01.2023.
//

import Foundation

protocol AppDetailPresenterProtocol: AnyObject {
    
    var app: SearchResult? { get }
    var reviews: Reviews? { get }
    
    func viewDidLoad()
}

protocol AppDetailInteractorOutputs: AnyObject {
    func beginRefreshing()
    func endRefreshing()
    func onError(message: String)
    func showApp(app: SearchResult)
    func showReviews(reviews: Reviews)
}

final class AppDetailPresenter: AppDetailPresenterProtocol {
    
    private weak var view: AppDetailViewProtocol?
    private let router: AppDetailRouterProtocol
    private let interactor: AppDetailInteractorProtocol
    
    private(set) internal var app: SearchResult?
    private(set) internal var reviews: Reviews?
    
    init(view: AppDetailViewProtocol, router: AppDetailRouterProtocol, interactor: AppDetailInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.interactor.delegate = self
    }
    
    func viewDidLoad() {
        self.view?.prepareCollectionView()
        self.view?.prepareActivityIndicatorView()
        self.interactor.getDetail()
        self.interactor.getReviews()
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
    
    func showApp(app: SearchResult) {
        self.app = app
        self.view?.dataRefreshed()
    }
    
    func showReviews(reviews: Reviews) {
        self.reviews = reviews
        self.view?.dataRefreshed()
    }
}
