//
//  MusicInteractor.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 6.01.2023.
//

import Foundation

protocol MusicInteractorProtocol: AnyObject {
    var delegate: MusicInteractorOutputs? { get set }
    var offset: Int { get set }
    
    func getMusics(searchTerm: String)
}

final class MusicInteractor: MusicInteractorProtocol {
    
    weak var delegate: MusicInteractorOutputs?
    private let service: MusicServiceProtocol
    
    var offset: Int = 20
    private var tracks: [ResultModel] = []
    
    init(service: MusicServiceProtocol = MusicService.shared) {
        self.service = service
    }
    
    func getMusics(searchTerm: String) {
        delegate?.beginRefreshing()
        
        service.fetchSearchedMusic(offset: self.offset, searchTerm: searchTerm) { [weak self] results in
            guard let self else { return }
            self.delegate?.endRefreshing()
            
            switch results {
            case .success(let tracks):
                self.tracks.append(contentsOf: tracks?.results ?? [])
                self.delegate?.showTracks(tracks: self.tracks)
                self.delegate?.dataRefreshed()
            case .failure(let error):
                self.delegate?.showError(message: error.localizedDescription)
            }
        }
    }
}

