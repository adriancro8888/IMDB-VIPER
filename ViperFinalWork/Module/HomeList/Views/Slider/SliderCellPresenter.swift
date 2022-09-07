//
//  SliderCellPresenter.swift
//  ViperFinalWork
//
//  Created by emre usul on 28.04.2022.
//

import Foundation

protocol SliderCellPresenterProtocol: AnyObject {
    func load()
}

final class SliderCellPresenter {
    
    weak var view: SliderCellProtocol?
    private let slider: Movie
    
    init (view: SliderCellProtocol? , slider: Movie) {
        self.view = view
        self.slider = slider
    }
}

extension SliderCellPresenter: SliderCellPresenterProtocol {
    func load() {
        view?.setImage(slider.posterPath ?? "")
        view?.setTitleLabel(slider.title ?? "") 
    }
    
    
}






