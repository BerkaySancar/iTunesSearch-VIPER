//
//  NetworkManager.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import Foundation

struct NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
}

extension NetworkManager {
    
    func sendRequest<T: Codable>(type: T.Type, url: String, httpMethod: String, completion: @escaping (Result<T, ServiceError>) -> Void) {
        
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error {
                print(error)
                completion(.failure(.invalidURL(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if 200...299 ~= response.statusCode {
                guard let data else { return }
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.noData))
                }
            } else {
                completion(.failure(.statusCode(code: response.statusCode)))
            }
        }
        .resume()
    }
}
