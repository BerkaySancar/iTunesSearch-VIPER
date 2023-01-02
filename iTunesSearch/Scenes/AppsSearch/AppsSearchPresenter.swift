//
//  AppSearchPresenter.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import Foundation

protocol AppsSearchPresenterProtocol: AnyObject {
    
    func viewDidLoad()
}

protocol AppsSearchInteractorOutputs: AnyObject {
    
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
    }
}

extension AppsSearchPresenter: AppsSearchInteractorOutputs {
    
}
