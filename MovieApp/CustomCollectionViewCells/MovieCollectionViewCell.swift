//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Ivan Ivanov on 3.12.22.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    
    let identifier = CellIdentifiers.MovieCollectionViewCell.rawValue
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
