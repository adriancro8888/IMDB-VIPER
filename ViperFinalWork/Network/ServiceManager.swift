//
//  ServiceManager.swift
//  ViperFinalWork
//
//  Created by emre usul on 25.04.2022.
//

import Foundation

protocol MoviesServiceProtocol {
    
    func fetchMovieList(completionHandler: @escaping (MovieListResult) -> ())
    func fetchDetail(movieId: Int , completionHandler: @escaping(MovieDetailResult) -> ())
    func fetchTopMovies(completionHandler: @escaping (TopMoviesResult) -> ())
    func fetchSimilarMovies(similarId:Int , completionHandler: @escaping (MovieSimilarResult) -> ())
    func fetchSearchResult(search:String , completionHandler: @escaping (SearchMovieResult) -> ())
}


struct MovieService: MoviesServiceProtocol {
    func fetchSearchResult(search: String, completionHandler: @escaping (SearchMovieResult) -> ()) {
        NetworkManager.shared.request(Router.movieSearch(searchText: search), decodeToType: SearchMoviesResponse.self, completionHandler: completionHandler)
    }
    
    func fetchSimilarMovies(similarId: Int, completionHandler: @escaping (MovieSimilarResult) -> ()) {
        NetworkManager.shared.request(Router.movieSimilar(similarId: similarId), decodeToType: MovieSimilarResponse.self, completionHandler: completionHandler)
    }
    
  
    
    
    func fetchTopMovies(completionHandler: @escaping (TopMoviesResult) -> ()) {
        NetworkManager.shared.request(Router.moviePlaying, decodeToType: TopMoviesResponse.self, completionHandler: completionHandler)
    }
    
   
    
    
    func fetchMovieList(completionHandler: @escaping (MovieListResult) -> ()) {
        NetworkManager.shared.request(Router.movieUpcoming, decodeToType: MovieListResponse.self, completionHandler: completionHandler)
    
    }
    
    func fetchDetail(movieId: Int, completionHandler: @escaping (MovieDetailResult) -> ()) {
        NetworkManager.shared.request(Router.movieDetail(movieId: movieId), decodeToType: MovieDetailResponse.self, completionHandler: completionHandler)
    }
    
    

}


