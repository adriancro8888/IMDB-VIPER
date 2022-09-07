//
//  HomeInteractor.swift
//  ViperFinalWork
//
//  Created by emre usul on 26.04.2022.
//

import Foundation

protocol HomeInteractorProtocol: AnyObject {
    func fetchMoviesList()
    func fetchTopMovies()
    func fetchMovieDetail(movieId: Int)
    func fetchSearchResult(searchText: String)
    
}

protocol HomeInteractorOutputProtocol: AnyObject {
    func fetchMoviesListOutput(result : MovieListResult)
    func fetchTopMovieOutput(result: TopMoviesResult)
    func fetchDetailOutput(result: MovieDetailResult)
    func fetchSearchResultOutput(result: SearchMovieResult)
}

typealias MovieListResult = Result<MovieListResponse,Error>
typealias TopMoviesResult = Result<TopMoviesResponse, Error>
typealias SearchMovieResult = Result<SearchMoviesResponse,Error>

fileprivate var movieService: MoviesServiceProtocol = MovieService()

final class HomeInteractor {
    var output: HomeInteractorOutputProtocol?
    
}

extension HomeInteractor: HomeInteractorProtocol {
    func fetchSearchResult(searchText: String) {
        movieService.fetchSearchResult(search: searchText) {  [weak self] result in
            guard let self = self else { return }
            self.output?.fetchSearchResultOutput(result: result)
        }
    }
    
    func fetchMovieDetail(movieId: Int) {
        movieService.fetchDetail(movieId: movieId) { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchDetailOutput(result:result)
        }
    }
    
    func fetchTopMovies() {
        movieService.fetchTopMovies{ [weak self] result in
            guard let self = self else { return }
            self.output?.fetchTopMovieOutput(result: result)
        }
    }
    
    func fetchMoviesList() {
        movieService.fetchMovieList { [weak self] results in
            guard let self = self else { return }
            self.output?.fetchMoviesListOutput(result: results)
        }
    }
    
    
    
}
