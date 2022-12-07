//
//  AddMovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Ivan Ivanov on 3.12.22.
//

import UIKit

class AddMovieCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setCollectionViewCellUI()
        
    }
    
    private func setCollectionViewCellUI() {
        backgroundColor = UIColor.darkGray
        layer.cornerRadius = 15
    }
    
}
