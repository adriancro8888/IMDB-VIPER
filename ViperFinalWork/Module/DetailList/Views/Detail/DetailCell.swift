//
//  DetailCell.swift
//  ViperFinalWork
//
//  Created by emre usul on 29.04.2022.
//

import UIKit
import Kingfisher

protocol DetailCellProtocol: AnyObject {
    func setDetailImage(_ imageUrl:String)
    func setDetailLabel(_ text:String)
    func setTitleLabel(_ title:String)
    func setDateLabel(_ text:String)
    func setRateLabel(_ rate:String)
    func favoriteButtonSetup()
}


class DetailCell: UITableViewCell {

   
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addFavorites: UIButton!
    
    var cellPresenter:DetailCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
     }
    }
    @IBAction func addFavorites(_ sender: Any) {
        cellPresenter.buttonClicked(movie: cellPresenter.movieSender())
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

   
    
}

extension DetailCell: DetailCellProtocol {
    func favoriteButtonSetup() {
        if cellPresenter?.checkFavoriteStatus(movie: cellPresenter.movieSender().id) == true {

            addFavorites.setImage(UIImage(systemName: "hand.thumbsup.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
              
            } else {
                addFavorites.setImage(UIImage(systemName: "hand.thumbsup")?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
            }
    }
    
    func setFavoritesButtonTitle(_ text: String, isAdded: Bool) {
        addFavorites.titleLabel?.lineBreakMode = .byWordWrapping
        addFavorites.titleLabel?.textAlignment = .center
        addFavorites.setImage(UIImage(systemName: text), for: .normal)
    }
    
    func setDateLabel(_ text: String) {
        self.dateLabel.text = text
    }
    
    func setRateLabel(_ rate: String) {
        self.rateLabel.text = rate
    }
    
   
    func setDetailImage(_ imageUrl: String) {
        let url = URL(string: "https://image.tmdb.org/t/p/original\(imageUrl)")
        detailImage.kf.setImage(with: url)
        
    }
    
    func setDetailLabel(_ text: String) {
        self.detailLabel.text = text
    }
    
    func setTitleLabel(_ title: String) {
        self.titleLabel.text = title
    }
    
    
}
