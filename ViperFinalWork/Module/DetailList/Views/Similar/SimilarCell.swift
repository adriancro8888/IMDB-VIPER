//
//  SimilarCell.swift
//  ViperFinalWork
//
//  Created by emre usul on 29.04.2022.
//

import UIKit

protocol SimilarCellProtocol:AnyObject {
    func setSimilarImage(_ image:String)
    func setSimilarTitle(_ title:String)
}

class SimilarCell: UICollectionViewCell {

    @IBOutlet weak var similarImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cellPresenter:SimilarCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}

extension SimilarCell:SimilarCellProtocol {
    func setSimilarImage(_ image: String) {
        let url = URL(string: "https://image.tmdb.org/t/p/original\(image)")
        similarImage.kf.setImage(with: url)    }
    
    func setSimilarTitle(_ title: String) {
        self.titleLabel.text = title
    }
    
    
}
