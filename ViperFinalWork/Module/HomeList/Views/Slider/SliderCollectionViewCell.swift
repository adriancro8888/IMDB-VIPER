//
//  SliderCollectionViewCell.swift
//  ViperFinalWork
//
//  Created by emre usul on 28.04.2022.
//

import UIKit
import Kingfisher

protocol SliderCellProtocol: AnyObject {
    func setImage(_ text: String)
    func setTitleLabel(_ text: String)
}

final class SliderCollectionViewCell: UICollectionViewCell {

 
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var cellPresenter: SliderCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

}
   

extension SliderCollectionViewCell: SliderCellProtocol {
    func setTitleLabel(_ text: String) {
        self.titleLabel.text = text
    }
    
    func setImage(_ text: String) {
      
        let url = URL(string: "https://image.tmdb.org/t/p/original\(text)")
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url) { result in
            
            switch result {
               
            case .success(_):
             
                break
            case .failure(_):
                self.imageView.image = UIImage(systemName: "star")
            }
        }
    }
    
   
    
}
