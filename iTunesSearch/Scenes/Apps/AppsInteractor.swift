//
//  AppsInteractor.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import Foundation

protocol AppsInteractorProtocol: AnyObject {
    
    var delegate: AppsInteractorOutputs? { get set }
    
    func getGroupApps()
    func getSocialApps()
}

final class AppsInteractor: AppsInteractorProtocol {
    
    weak var delegate: AppsInteractorOutputs?
    private let service: AppsServiceProtocol
    private let dispatchGroup = DispatchGroup()
    
    init(service: AppsServiceProtocol = AppsService.shared) {
        self.service = service
    }
    
    func getGroupApps() {
        delegate?.beginRefreshing()
        
        self.service.fetchGroupApps { [weak self] results in
            guard let self else { return }
            self.delegate?.endRefreshing()
            switch results {
            case .success(let apps):
                self.delegate?.showData(appGroup: apps ?? [])
                self.delegate?.dataRefreshed()
            case .failure(let error):
                self.delegate?.onError(message: error.localizedDescription)
            }
        }
    }
    
    func getSocialApps() {
        delegate?.beginRefreshing()
        
        self.service.fetchSocialApps { [weak self] results in
            guard let self else { return }
            self.delegate?.endRefreshing()
            
            switch results {
            case .success(let apps):
                self.delegate?.showSocialApps(socialApps: apps ?? [])
                self.delegate?.dataRefreshed()
            case .failure(let error):
                self.delegate?.onError(message: error.localizedDescription)
            }
        }
    }
}
