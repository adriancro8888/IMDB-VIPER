//
//  DetailViewController.swift
//  ViperFinalWork
//
//  Created by emre usul on 28.04.2022.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
    func reloadData()
    func showLoadingView()
    func hideLoadingView()
    func setTitle(_ title:String)
    func setupTableView()
    func setupCollectionView()
   

}

final class DetailViewController: UIViewController , LoadingShowable{
    
   
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!

    var presenter: DetailPresenterProtocol!
    var detail:MovieDetailResponse?
    var provider:UserDataProvider!
    
    init(provider:UserDataProvider) {
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        presenter.viewDidLoad()
        presenter.fetchSimilar(detail?.id ?? 0)
    }
}

extension DetailViewController:DetailViewControllerProtocol {
    
    func reloadData() {
        self.tableView.reloadData()
        self.collectionView.reloadData()
    }
    
    func showLoadingView() {
        showLoadingView()
    }
    
    func hideLoadingView() {
       hideLoadingView()
    }
    
    func setTitle(_ text: String) {
        self.title = text
    }
    
    func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.register(cellType: DetailCell.self)
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cellType:SimilarCell.self)
    }
    
   
    
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: DetailCell.self , for:indexPath)
        cell.selectionStyle = .none
        cell.cellPresenter = DetailCellPresenter.init(view: cell, detail: detail!, delegate: self, provider: provider)
        
        return cell
    }
    
    
}



extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: SimilarCell.self, for: indexPath)
       
        cell.cellPresenter = SimilarCellPresenter(view: cell, similar: presenter.similarMovie(indexPath.row)!, delegate: self)
            
        
        return cell
    }
    
    
}

extension DetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       presenter.didSelectRowAt(index: indexPath.row)
    }
}

extension DetailViewController: DetailCellDelegate , SimilarCellDelegate {

}
