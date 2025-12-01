//
//  UITableView.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 25/11/2568 BE.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerCell<cell: UITableViewCell>(
        _ cellType: cell.Type,
        bundle: Bundle = .main
    ) {
        let cellIdentifier = String(describing: cell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: bundle)
        self.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
    
    func dequeueCell<cell: UITableViewCell>(for indexPath: IndexPath) -> cell {
        return self.dequeueReusableCell(withIdentifier: String(describing: cell.self), for: indexPath) as! cell
    }
}
