//
//  AppsService.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import Foundation

protocol AppsServiceProtocol {
    
    func fetchSearchedApps(searchTerm: String, completion: @escaping (Result<[ResultModel], ServiceError>) -> Void)
    func fetchGroupApps(completion: @escaping (Result<[AppGroup]?, ServiceError>) -> Void)
    func fetchSocialApps(completion: @escaping (Result<[SocialApp]?, ServiceError>) -> Void)
    func fetchAppDetail(id: String, completion: @escaping (Result<SearchResult, ServiceError>) -> Void)
    func fetchCustomerReviews(id: String, completion: @escaping (Result<Reviews, ServiceError>) -> Void)
}

final class AppsService {
    
    static let shared = AppsService()
    private let dispatchGroup = DispatchGroup()
    
    private init() {}
}

extension AppsService: AppsServiceProtocol {
    
// MARK: - fetchSearchedApps
    func fetchSearchedApps(searchTerm: String, completion: @escaping (Result<[ResultModel], ServiceError>) -> Void) {
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

// MARK: - fetchGroupApps
    func fetchGroupApps(completion: @escaping (Result<[AppGroup]?, ServiceError>) -> Void) {
        var appGroups: [AppGroup] = []
        var group1: AppGroup? // for correctly row design.
        var group2: AppGroup? // 1-[topFree]
                              // 2-[topPaid]
        let topFreeUrl = "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/50/apps.json"
        let topPaidUrl =  "https://rss.applemarketingtools.com/api/v2/us/apps/top-paid/50/apps.json"
        
 // MARK: Dispatch Group
        dispatchGroup.enter()
        NetworkManager.shared.sendRequest(type: AppGroup.self, url: topFreeUrl, httpMethod: "GET") { [weak self] results in
            guard let self else { return }
            self.dispatchGroup.leave()
            switch results {
            case .success(let apps):
                group1 = apps
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        dispatchGroup.enter()
        NetworkManager.shared.sendRequest(type: AppGroup.self, url: topPaidUrl, httpMethod: "GET") { [weak self] results in
            guard let self else { return }
            self.dispatchGroup.leave()
            switch results {
            case .success(let apps):
                group2 = apps
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            if let group = group1 {
                appGroups.append(group)
            }
            if let group = group2 {
                appGroups.append(group)
            }
            completion(.success(appGroups))
        }
    }
    
// MARK: - fetchSocialApps
    func fetchSocialApps(completion: @escaping (Result<[SocialApp]?, ServiceError>) -> Void) {
        
        let url = "https://api.letsbuildthatapp.com/appstore/social"
        
        NetworkManager.shared.sendRequest(type: [SocialApp].self, url: url, httpMethod: "GET") { results in
            switch results {
            case .success(let apps):
                completion(.success(apps))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
// MARK: - fetchAppDetail
    func fetchAppDetail(id: String, completion: @escaping (Result<SearchResult, ServiceError>) -> Void) {
        
        let url = "https://itunes.apple.com/lookup?id=\(id)"
        
        NetworkManager.shared.sendRequest(type: SearchResult.self, url: url, httpMethod: "GET") { results in
            switch results {
            case .success(let app):
                completion(.success(app))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchCustomerReviews(id: String, completion: @escaping (Result<Reviews, ServiceError>) -> Void) {
        
        let url = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(id)/sortby=mostrecent/json?l=en&cc=us"
        
        NetworkManager.shared.sendRequest(type: Reviews.self, url: url, httpMethod: "GET") { results in
            switch results {
            case .success(let review):
                completion(.success(review))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
