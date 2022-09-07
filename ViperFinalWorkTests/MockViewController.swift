//
//  MockViewController.swift
//  ViperFinalWorkTests
//
//  Created by emre usul on 3.05.2022.
//

import Foundation
import UIKit
@testable import ViperFinalWork

final class MockViewController: HomeViewControllerProtocol {
    
    var isInvokedShowLoading = false
    var isInvokedHideLoading = false
    var isInvokedSetTitle = false
    var isInvokedSetupTable = false
    var isInvokedCollection = false
    var isInvokedSearch = false
    var isInvokedReload = false
    var isInvokedSetup = false
    var isInvokedConstraints = false
   
    
    func showLoadingView() {
        self.isInvokedShowLoading = true
    }
    
    func hideLoadingView() {
        self.isInvokedHideLoading = true
    }
    
    func setTitle(_ title: String) {
    }
    
    func setupTableView() {
        self.isInvokedSetupTable = true
    }
    
    func setupCollectionView() {
        self.isInvokedCollection = true
    }
    
    func setupSearchBar() {
        self.isInvokedSearch = true
    }
    
    func setupUI(isHidden: Bool) {
        self.isInvokedSetup = true
    }
    
    
    func applyConstraints(topAnchor: CGFloat) {
        self.isInvokedConstraints = true
    }
   
    func reloadData() {
        self.isInvokedReload = true
    }
    
    
}


