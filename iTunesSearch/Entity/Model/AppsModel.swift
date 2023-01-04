//
//  AppsModel.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 3.01.2023.
//

import Foundation

struct AppGroup: Codable {
    let feed: Feed
}

struct Feed: Codable {
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Codable {
    let id: String
    let name: String
    let artistName: String
    let artworkUrl100: String
}
