//
//  HomeViewController.swift
//  ViperFinalWork
//
//  Created by emre usul on 26.04.2022.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func reloadData()
    func showLoadingView()
    func hideLoadingView()
    func setTitle(_ title:String)
    func setupTableView()
    func setupCollectionView()
    func setupSearchBar()
    func setupUI(isHidden:Bool)
    func applyConstraints(topAnchor: CGFloat)
}


final class HomeViewController: UIViewController , LoadingShowable{

    var presenter:HomePresenterProtocol!
    

    @IBOutlet weak var topAnchor: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
  
    var timer = Timer()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
        
        DispatchQueue.main.async { [self] in
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeBannerPage), userInfo: nil, repeats: true)
                }
        
        
    }
    
    @objc func changeBannerPage() {
                 
             if counter < 20 {
                  let index = IndexPath.init(item: counter, section: 0)
                  self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
                  counter += 1
             } else {
                  counter = 0
                  let index = IndexPath.init(item: counter, section: 0)
                 self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
                   counter = 1
               }
          }
    

}

extension HomeViewController: HomeViewControllerProtocol {
    func setupUI(isHidden: Bool) {
        collectionView.isHidden = isHidden
    }
    
    func applyConstraints(topAnchor: CGFloat) {
        self.topAnchor.constant = topAnchor
    }
    
    
    
    func reloadData() {
        self.tableView.reloadData()
        self.collectionView.reloadData()
        
    }
    
    func showLoadingView() {
       showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setupSearchBar() {
        searchBar.delegate = self

      
      
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: ResultsTableViewCell.self)
     
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cellType: SliderCollectionViewCell.self)
    }
    
    
}



extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        
        
        let cell = tableView.dequeueReusableCell(with: ResultsTableViewCell.self, for: indexPath)
        cell.selectionStyle = .none
        if let result = presenter.movie(indexPath.row) {
            cell.cellPresenter = ResultsCellPresenter(view: cell, result: result)
        }
        
        return cell
    }
    
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
        
    }
}




extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(with: SliderCollectionViewCell.self, for: indexPath)
        if let topSource = presenter.topMovie(indexPath.row) {
            cell.cellPresenter = SliderCellPresenter(view: cell, slider: topSource)
        }
        return cell
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfRows()
        
    }
    
   
  
    
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItemAt(index: indexPath.row)
    }
    
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
                return 0.0
            }

            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                return 0.0
            }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let bounds = UIScreen.main.bounds
            let width = bounds.size.width
          
        return CGSize(width: width, height: collectionView.frame.height)

         
        }
}

//MARK: - SearchBar

extension HomeViewController: UISearchBarDelegate {
     
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchTextChanged(searchText)
        

       
   }
 
    
}

