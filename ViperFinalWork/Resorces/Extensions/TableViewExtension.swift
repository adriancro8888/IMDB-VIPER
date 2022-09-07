//
//  TableViewExtension.swift
//  ViperFinalWork
//
//  Created by emre usul on 27.04.2022.
//


import UIKit
import Foundation

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing:self)
    }
    
    var className:String {
        return type(of:self).className
    }
}

extension NSObject: ClassNameProtocol {}

//MARK: -UITableView

public extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type,bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib,forCellReuseIdentifier: className)
    }
    
    func register<T: UITableViewCell>(cellTypes: [T.Type],bundle: Bundle? = nil) {
         cellTypes.forEach { register(cellType: $0, bundle: bundle)}
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexpath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.className, for: indexpath) as! T
    }
    
}

public extension Collection where Indices.Iterator.Element == Index {
    
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self [index] : nil
    }
}

public extension UICollectionView {
    func register<T: UICollectionViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }

    func register<T: UICollectionViewCell>(cellTypes: [T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }

    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as! T
    }
}
