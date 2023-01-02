//
//  ServiceError.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import Foundation

enum ServiceError: Error {
    
    case invalidURL(Error)
    case noData
    case statusCode(code: Int)
}
