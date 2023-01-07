//
//  MusicService.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 7.01.2023.
//

import Foundation

protocol MusicServiceProtocol {
    
    func fetchSearchedMusic(offset: Int, searchTerm: String, completion: @escaping (Result<SearchResult?, ServiceError>) -> Void)
}

final class MusicService {
    
    static let shared = MusicService()
    
    private init() { }
}

extension MusicService: MusicServiceProtocol {
    
    func fetchSearchedMusic(offset: Int, searchTerm: String, completion: @escaping (Result<SearchResult?, ServiceError>) -> Void) {
        let url = "https://itunes.apple.com/search?term=\(searchTerm)&offset=\(offset)&limit=20"
        
        NetworkManager.shared.sendRequest(type: SearchResult.self,
                                          url: url,
                                          httpMethod: "GET") { results in
            
            switch results {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
