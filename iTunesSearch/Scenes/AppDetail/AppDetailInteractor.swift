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
    func getReviews()
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
                self.delegate?.showApp(app: app)
            case .failure(let error):
                self.delegate?.onError(message: error.localizedDescription)
            }
        }
    }
    
    func getReviews() {
        self.delegate?.beginRefreshing()
        service.fetchCustomerReviews(id: self.id) { [weak self] results in
            guard let self else { return }
            self.delegate?.endRefreshing()
            
            switch results {
            case .success(let review):
                self.delegate?.showReviews(reviews: review)
            case .failure(let error):
                self.delegate?.onError(message: error.localizedDescription)
            }
        }
    }
}
