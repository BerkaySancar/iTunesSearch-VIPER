//
//  AppDetailInteractor.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 4.01.2023.
//

import Foundation

protocol AppDetailInteractorProtocol: AnyObject {
    
    var delegate: AppDetailInteractorOutputs? { get set }
    
    func getDetail()
}

final class AppDetailInteractor: AppDetailInteractorProtocol {
    
    weak var delegate: AppDetailInteractorOutputs?
    private let service: AppsServiceProtocol
    
    private var id: String
    
    init(id: String, service: AppsServiceProtocol = AppsService.shared) {
        self.id = id
        self.service = service
    }
    
    func getDetail() {
        self.delegate?.beginRefreshing()
        service.fetchAppDetail(id: self.id) { [weak self] results in
            guard let self else { return }
            self.delegate?.endRefreshing()
            
            switch results {
            case .success(let app):
                self.delegate?.loadApp(app: app)
            case .failure(let error):
                self.delegate?.onError(message: error.localizedDescription)
            }
        }
    }
}
