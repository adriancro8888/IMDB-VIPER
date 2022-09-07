//
//  MockInteractor.swift
//  ViperFinalWorkTests
//
//  Created by emre usul on 3.05.2022.
//

import Foundation
@testable import ViperFinalWork

final class MockInteractor: HomeInteractorProtocol {
    
    var invokedFetchMovie = false
    var invokeFetchMovieCount = 0
    
    func fetchMoviesList() {
       
    }
    
    func fetchTopMovies() {
        
    }
    
    func fetchMovieDetail(movieId: Int) {
        
    }
    
    func fetchSearchResult(searchText: String) {
        
    }
    
    
}
