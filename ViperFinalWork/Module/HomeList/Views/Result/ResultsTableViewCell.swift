//
//  ResultsTableViewCell.swift
//  ViperFinalWork
//
//  Created by emre usul on 27.04.2022.
//

import UIKit
import Kingfisher

protocol ResultsCellProtocol: AnyObject {
    func setTitleLabel(_ text:String)
    func setDescriptionLabel(_ text:String)
    func setImage(_ text:String)
    func setDate(_ text:String)
}

final class ResultsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moviesImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    var cellPresenter: ResultsCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

   
}

extension ResultsTableViewCell: ResultsCellProtocol {
    func setDate(_ text: String) {
        self.dateLabel.text = text
    }
    
    func setImage(_ text: String) {
        moviesImage.layer.cornerRadius = CGFloat(10)
        
        let url = URL(string: text)
        self.moviesImage.kf.setImage(with:url)
      
    }
    
   
    
    func setTitleLabel(_ text: String) {
        self.titleLabel.text = text
    }
    
    func setDescriptionLabel(_ text: String) {
        self.descriptionLabel.text = text
    }
    
    
}
