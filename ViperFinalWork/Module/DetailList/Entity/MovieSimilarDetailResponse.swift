//
//  MovieSimilarDetailResponse.swift
//  ViperFinalWork
//
//  Created by emre usul on 29.04.2022.
//

import Foundation

struct MovieSimilarResponse: Codable {
    let page: Int?
    var results: [Similar]
    let totalPages, totalResults: Int?
    
   enum CodingKeys: String, CodingKey {
        case page,results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Similar: Codable {
    let id: Int?
    let title: String?
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}
