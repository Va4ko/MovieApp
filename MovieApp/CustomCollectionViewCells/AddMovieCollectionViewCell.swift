//
//  AddMovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Ivan Ivanov on 3.12.22.
//

import UIKit

class AddMovieCollectionViewCell: UICollectionViewCell {
    
    
    let identifier = CellIdentifiers.AddMovieCollectionViewCell.rawValue
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setCollectionViewCellUI()
        
    }
    
    func setCollectionViewCellUI() {
        backgroundColor = UIColor.darkGray
        layer.cornerRadius = 15
    }
    
    
    
}
