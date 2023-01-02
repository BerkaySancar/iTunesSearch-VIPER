//
//  SearchModel.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import Foundation

struct SearchResult: Codable {
    let resultCount: Int
    let results: [App]
}

struct App: Codable {
    let trackName: String
    let primaryGenreName: String
    let averageUserRating: Float?
    let screenshotUrls: [String]
    let artworkUrl100: String
}
