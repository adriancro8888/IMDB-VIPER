//
//  DetailPresenter.swift
//  ViperFinalWork
//
//  Created by emre usul on 29.04.2022.
//

import Foundation

protocol DetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfItems() -> Int
    func detail(_ index: Int) -> MovieDetailResponse?
    func didSelectRowAt(index: Int)
    func similarMovie(_ index:Int) -> Similar?
    func numberOfRows() -> Int
    func fetchSimilar(_ id: Int)
   
   
}


final class DetailPresenter: DetailPresenterProtocol{
    
    
    func fetchSimilar(_ id: Int) {
        interactor.fetchSimilarMovies(similarId: id)
    }
    
    private var similar:[Similar] = []
    private var details: [MovieDetailResponse] = []
    unowned var view: DetailViewControllerProtocol?
    let router: DetailRouterProtocol!
    let interactor: DetailInteractorProtocol!
    
    
    init(view: DetailViewControllerProtocol , router : DetailRouterProtocol, interactor: DetailInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor 
    }
    
    func viewDidLoad() {
        view?.setupTableView()
        view?.setupCollectionView()
        
      
    }
    
    func numberOfItems() -> Int {
        return 1
    }
    
    func detail(_ index: Int) -> MovieDetailResponse? {
         details[safe: index]
       
    }
    
    func didSelectRowAt(index: Int) {
        guard let similarMovies = similarMovie(index) else { return }
        interactor.fetchDetail(moviesId: similarMovies.id ?? 0)
    }
    
    
    func similarMovie(_ index: Int) -> Similar?{
        return similar[safe : index]
        
    }
    
    func numberOfRows() -> Int {
        similar.count
    }
    
}


extension DetailPresenter: DetailInteractorOutputProtocol {
    func fetchSimilarMovieOutput(result: MovieSimilarResult) {
        switch result {
        case .success(let similarMovie):
            similar = similarMovie.results
            view?.reloadData()
        case .failure(let error):
            print(error)
        }
    }
    
    func fetchDetailOutput(result: MovieDetailResult) {
        switch result {
        case .success(let similarMovieDetailResult):
            router.navigate(.detail(movie: similarMovieDetailResult))
        case .failure(let error):
            print(error)
        }
    }
    
    
}
