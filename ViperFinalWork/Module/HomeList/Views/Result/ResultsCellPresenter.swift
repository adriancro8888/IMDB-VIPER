//
//  ResultsCellPresenter.swift
//  ViperFinalWork
//
//  Created by emre usul on 27.04.2022.
//

import Foundation

protocol ResultsCellPresenterProtocol: AnyObject {
    func load()
    
}

final class ResultsCellPresenter {
    
    weak var view: ResultsCellProtocol?
    
    private let result:Movie
    
    
    init(view: ResultsCellProtocol? , result:Movie) {
        self.view = view
        self.result = result
        print(result)
    }
}

extension ResultsCellPresenter: ResultsCellPresenterProtocol {
    func load() {
        view?.setTitleLabel(result.title ?? "")
        view?.setDescriptionLabel(result.overview ?? "")
        view?.setImage("https://image.tmdb.org/t/p/original" + (result.posterPath ?? ""))
        view?.setDate(result.releaseDate ?? "")
    }
    
    
}
