//
//  MusicPresenter.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 6.01.2023.
//

import Foundation

protocol MusicPresenterProtocol: AnyObject {
    
    func viewDidLoad()
}

protocol MusicInteractorOutputs: AnyObject {
    
}

final class MusicPresenter: MusicPresenterProtocol {
    
    private weak var view: MusicViewProtocol?
    private let router: MusicRouterProtocol
    private let interactor: MusicInteractorProtocol
    
    init(view: MusicViewProtocol, router: MusicRouterProtocol, interactor: MusicInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.interactor.delegate = self
    }
    
    func viewDidLoad() {
        view?.prepareCollectionView()
    }
}

extension MusicPresenter: MusicInteractorOutputs {
    
}
