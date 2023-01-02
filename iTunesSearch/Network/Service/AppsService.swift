//
//  AppsService.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import Foundation

protocol AppsServiceProtocol {
    
    func fetchApps(searchTerm: String, completion: @escaping (Result<[App], ServiceError>) -> Void)
}

final class AppsService {
    
    static let shared = AppsService()
    
    private init() {}
}

extension AppsService: AppsServiceProtocol {
    
    func fetchApps(searchTerm: String, completion: @escaping (Result<[App], ServiceError>) -> Void) {
        let url = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        
        NetworkManager.shared.sendRequest(type: SearchResult.self, url: url, httpMethod: "GET") { results in
            
            switch results {
            case .success(let apps):
                completion(.success(apps.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
