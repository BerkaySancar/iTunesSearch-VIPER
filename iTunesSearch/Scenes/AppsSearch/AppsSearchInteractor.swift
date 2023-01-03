//
//  AppsSearchInteractor.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import Foundation

protocol AppsSearchInteractorProtocol: AnyObject {
    
    var delegate: AppsSearchInteractorOutputs? { get set }
    
    func getData(searchTerm: String)
}

final class AppsSearchInteractor: AppsSearchInteractorProtocol {
    
    weak var delegate: AppsSearchInteractorOutputs?
    private weak var timer: Timer?
    
    private let service: AppsServiceProtocol
    
    init(service: AppsServiceProtocol = AppsService.shared) {
        self.service = service
    }
    
    func getData(searchTerm: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            guard let self else { return }
            self.delegate?.beginRefreshing()
            self.service.fetchSearchedApps(searchTerm: searchTerm) { [weak self] results in
                guard let self else { return }
                self.delegate?.endRefreshing()
                switch results {
                case .success(let apps):
                    self.delegate?.showApps(apps: apps)
                    self.delegate?.dataRefreshed()
                case .failure(let error):
                    self.delegate?.onError(message: "\(error.localizedDescription)")
                }
            }
        }
    }
}
