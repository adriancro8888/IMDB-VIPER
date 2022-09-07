//
//  DetailInteractor.swift
//  ViperFinalWork
//
//  Created by emre usul on 28.04.2022.
//

import Foundation

protocol DetailInteractorProtocol: AnyObject {
    func fetchDetail(moviesId: Int)
    func fetchSimilarMovies(similarId:Int)
}

protocol DetailInteractorOutputProtocol: AnyObject {
    func fetchDetailOutput(result:MovieDetailResult)
    func fetchSimilarMovieOutput(result:MovieSimilarResult)
}

typealias MovieSimilarResult = Result<MovieSimilarResponse,Error>
typealias MovieDetailResult = Result<MovieDetailResponse,Error>

fileprivate var movieService: MoviesServiceProtocol = MovieService()



final class DetailInteractor {
    var output: DetailInteractorOutputProtocol?
}

extension DetailInteractor: DetailInteractorProtocol {
  
    
    func fetchSimilarMovies(similarId: Int) {
        movieService.fetchSimilarMovies(similarId: similarId){ [weak self] result in guard let self = self else { return }
            self.output?.fetchSimilarMovieOutput(result: result)
       
        }
    }
    
    func fetchDetail(moviesId: Int) {
        movieService.fetchDetail(movieId: moviesId) { [weak self] result in
           guard let self = self else { return }
           self.output?.fetchDetailOutput(result: result)
        }
    }
    
    
}
