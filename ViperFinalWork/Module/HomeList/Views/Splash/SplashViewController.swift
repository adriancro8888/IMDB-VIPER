//
//  SplashViewController.swift
//  ViperFinalWork
//
//  Created by emre usul on 26.04.2022.
//

import UIKit

protocol SplashViewControllerProtocol: AnyObject {
    func noInternetConnection()
}

class SplashViewController: UIViewController {

    var presenter: SplashPresenterProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        presenter.viewDidAppear()
    }


   

}

extension SplashViewController: SplashViewControllerProtocol {
    
    func noInternetConnection() {
        
    }
    
    
}
