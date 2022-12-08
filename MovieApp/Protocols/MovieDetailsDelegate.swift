//
//  MovieDetailsDelegate.swift
//  MovieApp
//
//  Created by Ivan Ivanov on 8.12.22.
//

import Foundation

protocol MovieDetailsDelegate: AnyObject {
    func movieData(movie: Movie)
}
