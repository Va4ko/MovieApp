//
//  MovieDataSource.swift
//  MovieApp
//
//  Created by Ivan Ivanov on 8.12.22.
//

import Foundation

class MovieDataSource {
    
    static let shared = MovieDataSource()
    
    var movies: [Movie]?
    
    init(){}
    
}
