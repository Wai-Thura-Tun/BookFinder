//
//  UICollectionView.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 11/10/2568 BE.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func registerCell<cell: UICollectionViewCell>(
        _ cellType: cell.Type,
        bundle: Bundle = .main
    ) {
        let identifier = String(describing: cell.self)
        self.register(UINib(nibName: identifier, bundle: bundle), forCellWithReuseIdentifier: identifier)
    }
    
    func dequeueCell<cell: UICollectionViewCell>(for indexPath: IndexPath) -> cell {
        return self.dequeueReusableCell(withReuseIdentifier: String(describing: cell.self), for: indexPath) as! cell
    }
}
