    //
    //  CarouselCell.swift
    //  BookFinder
    //
    //  Created by Wai Thura Tun on 28/11/2568 BE.
    //

    import UIKit

    class CarouselCell: UITableViewCell {

        @IBOutlet weak var cvCarousel: UICollectionView!
        @IBOutlet weak var lblTitle: UILabel!
        
        private var dataSource: UICollectionViewDiffableDataSource<Int, Book>!
        
        var data: [Book] = [] {
            didSet {
                lblTitle.text = "Special Books"
                self.applySnapshot()
            }
        }
        
        nonisolated override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
            MainActor.assumeIsolated {
                setupViews()
                createLayout()
                setupDataSource()
            }
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }
        
        private func setupViews() {
            cvCarousel.registerCell(CarouselItemCell.self)
        }
        
        private func setupDataSource() {
            dataSource = UICollectionViewDiffableDataSource(collectionView: cvCarousel) { collectionView, indexPath, book in
                let cell: CarouselItemCell = collectionView.dequeueCell(for: indexPath)
                cell.book = book
                return cell
            }
        }
        
        private func createLayout() {
            let item = NSCollectionLayoutItem(layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1))
            )
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.28), heightDimension: .fractionalHeight(1)), subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = 20
            section.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
            let layout = UICollectionViewCompositionalLayout(section: section)
            self.cvCarousel.setCollectionViewLayout(layout, animated: true)
        }
        
        private func applySnapshot() {
            var snapshot = NSDiffableDataSourceSnapshot<Int, Book>()
            snapshot.appendSections([0])
            snapshot.appendItems(self.data, toSection: 0)
            dataSource?.apply(snapshot)
        }
    }
