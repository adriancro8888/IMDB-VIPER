//
//  DetailCellPresenter.swift
//  ViperFinalWork
//
//  Created by emre usul on 29.04.2022.
//

import Foundation

protocol DetailCellPresenterProtocol {
    func load()
    func buttonClicked(movie:MovieDetailResponse)
    func movieSender() -> MovieDetailResponse
    func checkFavoriteStatus(movie: Int) -> Bool
}

protocol DetailCellDelegate:AnyObject {
}


final class DetailCellPresenter {

    weak var view:DetailCellProtocol?
    private var detail: MovieDetailResponse
    weak var delegate: DetailCellDelegate?
    private var provider:UserDataProvider
    
    
    init(view:DetailCellProtocol? , detail: MovieDetailResponse , delegate: DetailCellDelegate , provider: UserDataProvider) {
        self.view = view
        self.detail = detail
        self.delegate = delegate
        self.provider = provider
        
    }
    
    
    
    private func addMovieToFavorites(card: MovieDetailResponse) {
        provider.addMovieToFavorites(movie: card)
    }

    private func removeMovieFromFavorites(card: MovieDetailResponse) {
        provider.removeMovieFromFavorites(card: card)
    }
    

}

extension DetailCellPresenter:DetailCellPresenterProtocol {
    func buttonClicked(movie: MovieDetailResponse) {
        if provider.isFavorite(movieId: movie.id) == true {
            removeMovieFromFavorites(card: movie)
                view?.favoriteButtonSetup()
            }else{
                addMovieToFavorites(card: movie)
                view?.favoriteButtonSetup()
            }
    }
    
    func movieSender() -> MovieDetailResponse {
        return detail
    }
    
    func checkFavoriteStatus(movie: Int) -> Bool {
        if provider.isFavorite(movieId: movie) == true {
                return true
            } else {
                return false
            }
        
    }
    
    func load() {
        view?.setTitleLabel(detail.title ?? "")
        view?.setDetailLabel(detail.overview ?? "")
        view?.setDetailImage(detail.backdropPath ?? "")
        view?.setDateLabel(detail.releaseDate ?? "")
        view?.setRateLabel("\(detail.voteAverage) / 10")
        view?.favoriteButtonSetup()
    }
    
    
}
