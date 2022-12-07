//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Ivan Ivanov on 3.12.22.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(movie: Movie) {
        guard let imageData = movie.poster else { return }
        moviePoster.image = UIImage(data: imageData)
    }
    
}
