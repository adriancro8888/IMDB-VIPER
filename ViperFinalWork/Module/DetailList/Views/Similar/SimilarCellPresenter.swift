//
//  SimilarCellPresenter.swift
//  ViperFinalWork
//
//  Created by emre usul on 29.04.2022.
//

import Foundation

protocol SimilarCellPresenterProtocol {
    func load()
}

protocol SimilarCellDelegate: AnyObject {
}


final class SimilarCellPresenter {
    
    weak var view: SimilarCellProtocol?
    private var similar:Similar
    weak var delegate: SimilarCellDelegate?
    
    init (view:SimilarCellProtocol? , similar: Similar, delegate: SimilarCellDelegate) {
        self.view = view
        self.similar = similar
        self.delegate = delegate
  }
}

extension SimilarCellPresenter: SimilarCellPresenterProtocol {
    func load() {
        view?.setSimilarTitle(similar.title ?? "")
        view?.setSimilarImage(similar.posterPath ?? "")
        
    }
}
