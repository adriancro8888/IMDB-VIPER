//
//  MovieDetailResponse.swift
//  ViperFinalWork
//
//  Created by emre usul on 25.04.2022.
//

import Foundation

struct MovieDetailResponse: Codable {
    let backdropPath: String?
    let imdbID , title , overview:String?
    var addFavouriteList:Bool = false
    var id:Int
    let releaseDate: String?
    let voteAverage: Double
    var favoritesStatus: Bool = false
    
    enum CodingKeys: String, CodingKey {
            case backdropPath = "backdrop_path"
            case imdbID = "imdb_id"
            case title
            case overview
            case releaseDate = "release_date"
            case id
            case voteAverage = "vote_average"
        }
}

