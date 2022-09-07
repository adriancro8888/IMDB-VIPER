//
//  MovieListResponse.swift
//  ViperFinalWork
//
//  Created by emre usul on 25.04.2022.
//

import Foundation

struct MovieListResponse: Codable {
    let page: Int?
    let results: [Movie]
    let totalPages, totalResults: Int?
}

struct Movie: Codable {
    let id:Int
    let title, overview: String?
    let posterPath: String?
    let releaseDate: String?
    let voteAverage:Double?
    
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case overview , id , title
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
      
    }
}




