//
//  MusicPresenter.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 6.01.2023.
//

import Foundation

protocol MusicPresenterProtocol: AnyObject {
    
    func viewDidLoad()
    func loadMoreMusic()
}

protocol MusicInteractorOutputs: AnyObject {
    func beginRefreshing()
    func endRefreshing()
    func dataRefreshed()
    func showError(message: String)
    func showTracks(tracks: [ResultModel])
}

final class MusicPresenter: MusicPresenterProtocol {
    
    private let searchTerm = "wizkhalifa"
    
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
        view?.prepareActivityIndicatorView()
        interactor.getMusics(searchTerm: self.searchTerm)
    }
    
    func loadMoreMusic() {
        interactor.offset += 20
        interactor.getMusics(searchTerm: self.searchTerm)
    }
}

extension MusicPresenter: MusicInteractorOutputs {
    func beginRefreshing() {
        view?.beginRefreshing()
    }
    
    func endRefreshing() {
        view?.endRefreshing()
    }
    
    func dataRefreshed() {
        view?.dataRefreshed()
    }
    
    func showError(message: String) {
        view?.onError(message: message)
    }
    
    func showTracks(tracks: [ResultModel]) {
        view?.showTracks(tracks: tracks)
    }
}
