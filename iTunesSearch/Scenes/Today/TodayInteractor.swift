//
//  TodayInteractor.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import Foundation

protocol TodayInteractorProtocol: AnyObject {
    var delegate: TodayInteractorOutputs? { get set }
    
    func getGroupApps()
}

final class TodayInteractor: TodayInteractorProtocol {
    
    weak var delegate: TodayInteractorOutputs?
    private let service: AppsServiceProtocol
    
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
}
