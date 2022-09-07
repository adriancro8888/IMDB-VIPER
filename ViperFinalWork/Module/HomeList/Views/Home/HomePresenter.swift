//
//  HomePresenter.swift
//  ViperFinalWork
//
//  Created by emre usul on 26.04.2022.
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfItems() -> Int
    func movie(_ index: Int) -> Movie?
    
    func didSelectRowAt(index: Int)
    func topMovie(_ index:Int) -> Movie?
    func numberOfRows() -> Int
    func didSelectItemAt(index:Int)
    func searchTextChanged(_ text:String)
    
}

final class HomePresenter: HomePresenterProtocol {
    
    

    unowned var view:HomeViewControllerProtocol?
    let router: HomeRouterProtocol!
    let interactor: HomeInteractorProtocol!
    
    private var movies: [Movie] = []
    private var topMovie: [Movie] = []
    private var searchMovies: [Movie] = []
    var isFiltering: Bool = false
    
    
    init(view: HomeViewControllerProtocol , router : HomeRouterProtocol , interactor: HomeInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        view?.setupTableView()
        view?.setupCollectionView()
        view?.setTitle("Movies")
        view?.setupSearchBar()
        fetchMoviesList()
    }
    
    func numberOfItems() -> Int {
        if isFiltering == true {
            return searchMovies.count
        } else {
            return movies.count
        }
    }
    
    func movie(_ index: Int) -> Movie? {
        if isFiltering == true {
            return searchMovies[safe: index]
        } else {
            return movies[safe: index]
        }
    }
    
    func didSelectRowAt(index: Int) {
        guard let result = movie(index) else { return }
        interactor.fetchMovieDetail(movieId: result.id)
        
    }
    
    private func fetchMoviesList() {
        view?.showLoadingView()
        interactor.fetchMoviesList()
        interactor.fetchTopMovies()
    }
    
    func topMovie(_ index: Int) -> Movie? {
        return topMovie[safe : index]
    }
    
    func numberOfRows() -> Int {
        return topMovie.count
    }
    
    func didSelectItemAt(index: Int) {
        guard let topMovie = topMovie(index) else { return }
        interactor.fetchMovieDetail(movieId: topMovie.id ?? 0)
    }
    
    func searchTextChanged(_ text: String) {
        if text.count < 2 {
            if text.isEmpty == true{
                view?.reloadData()
                isFiltering = false
                view?.setupUI(isHidden: false)
                view?.applyConstraints(topAnchor: 300)
            }
            return
        } else {
            isFiltering = true
            view?.setupUI(isHidden: true)
            view?.applyConstraints(topAnchor: 50)
          
            interactor.fetchSearchResult(searchText: text)
        }
    }
    
   
}

extension HomePresenter : HomeInteractorOutputProtocol {
   
    
    func fetchDetailOutput(result: MovieDetailResult) {
      
        switch result {
            
        case .success(let movieDetail):
            router.navigate(.detail(result: movieDetail))
        case .failure(let error):
            print(error)
        }
        
    }
    
    func fetchTopMovieOutput(result: TopMoviesResult) {
        view?.hideLoadingView()
        switch result {
            
        case .success(let topSourcesResult):
            topMovie = topSourcesResult.results ?? []
            view?.reloadData()
            
        case .failure(let error):
            print(error)
        }
    }
    
    func fetchMoviesListOutput(result: MovieListResult) {
            view?.hideLoadingView()
            switch result {
                
            case .success(let resultDetail):
                movies = resultDetail.results 
                view?.reloadData()
              
            case .failure(let error):
                print(error)
                            }
        }
    
    func fetchSearchResultOutput(result: SearchMovieResult) {
        switch result {
        case .success(let searchResult):
            searchMovies = searchResult.results ?? []
            view?.reloadData()
            print(searchMovies)
        case .failure(let error):
            print(error)
        }
    }
}
    
    
    
    

