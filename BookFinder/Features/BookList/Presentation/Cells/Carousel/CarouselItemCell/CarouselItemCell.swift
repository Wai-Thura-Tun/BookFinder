//
//  CarouselItemCell.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 28/11/2568 BE.
//

import UIKit

class CarouselItemCell: UICollectionViewCell {

    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    
    private var task: Task<Void, Never>?
    
    private let imageDownloader: ImageDownloader = Resolver.shared.resolve(ImageDownloader.self)
    
    var book: Book? {
        didSet {
            if let book = book {
                configureCell(with: book)
            }
        }
    }
    
    nonisolated override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        MainActor.assumeIsolated {
            imgCover.layer.cornerRadius = 10
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        task?.cancel()
        task = nil
        
        lblTitle.text = nil
        lblAuthor.text = nil
        imgCover.image = nil
    }

    private func configureCell(with book: Book) {
        lblTitle.text = book.name
        lblAuthor.text = book.authorName
        imgCover.image = UIImage(named: "book_placeholder")
        
        guard let urlString = book.cover else { return }
        
        task = Task { @MainActor [weak self] in
            guard let self = self else { return }
            
            if Task.isCancelled {
                return
            }
            
            do {
                let image = try await self.imageDownloader.image(for: urlString)
                
                if !Task.isCancelled {
                    self.imgCover.image = image
                }
            }
            catch {
                if Task.isCancelled {
                    self.imgCover.image = UIImage(named: "book_error")
                }
            }
        }
    }
}
