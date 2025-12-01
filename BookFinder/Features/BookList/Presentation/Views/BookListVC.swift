//
//  BookListVC.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 19/11/2568 BE.
//

import UIKit

class BookListVC: UIViewController, Storyboarded {

    @IBOutlet weak var tblBookList: UITableView!
    
    weak var coordinator: MainCoordinator?
    
    private var vm: BookListVM!
    
    private var dataSource: UITableViewDiffableDataSource<Int, HomeData>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        assert(vm != nil, "BooKlistVM must be configured before viewDidLoad")
        
        self.setUpViews()
        self.setUpBindings()
        self.setUpDataSource()
        self.updateNavBar()
        self.vm.getBooks()
    }
    
    private func setUpViews() {
        tblBookList.registerCell(NormalCell.self)
        tblBookList.registerCell(CarouselCell.self)
    }
    
    private func setUpBindings() {
        
    }
    
    private func setUpDataSource() {
        dataSource = UITableViewDiffableDataSource<Int, HomeData>(tableView: tblBookList) { tableView, indexPath, homeData in
            switch homeData {
            case .specialBook(let data):
                let cell: CarouselCell = tableView.dequeueCell(for: indexPath)
                cell.data = data.books
                return cell
            case .normalBook(let book):
                let cell: NormalCell = tableView.dequeueCell(for: indexPath)
                cell.book = book
                return cell
            }
        }
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, HomeData>()
        snapshot.appendSections([0])
        snapshot.appendItems(self.vm.books, toSection: 0)
        dataSource.apply(snapshot)
    }
    
    func configure(with vm: BookListVM) {
        self.vm = vm
        self.vm.delegate = self
    }
    
    private func updateNavBar() {
        self.title = "Book Lists"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: #selector(onTapClose))
    }
    
    @objc private func onTapClose() {
        
    }

}

extension BookListVC: BookListViewDelegate {
    func onLoadBooksSuccess() {
        self.applySnapshot()
    }
    
    func onError(error message: String) {
        
    }
}
