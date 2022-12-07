//
//  Constants.swift
//  MovieApp
//
//  Created by Ivan Ivanov on 7.12.22.
//

import Foundation

public struct Constants {
    public struct Titles {
        static let movieListViewControllerTitle = "Movies"
        static let introScreenShowMoviesBtnTitle = "Show movies"
        static let introScreenAddMovieBtnTitle = "Add movie"
        static let createMovieViewControllerTitleAddMovie = "Add movie"
        static let createMovieViewControllerTitleEditMovie = "Edit movie"
        static let createMovieViewControllerBtnTitleAddMovie = "Add movie"
        static let createMovieViewControllerBtnTitleEditMovie = "Edit movie"
    }
    
    public struct AddMovie {
        static let genres = ["Action", "Fantasy", "Science fiction", "Thriller", "Drama"]
        static let posters = ["Avatar", "Batman", "Gladiator", "Interstellar", "LordOfTheRings", "OnceUponATimeInAmerica", "Shawshank", "StarWars", "TheGodfather", "TheMatrix"]
    }
    
    public struct TextFieldsPlaceholders {
        static let titleField = "Title"
        static let releaseYearField = "Release Year"
        static let shortDescriptionField = "Short Description"
        static let genreField = "Genre"
    }
    
    public struct AlertMessages {
        static let textFields = "Title field and Short description field must contain more than 3 characters. Long description field must contain more than 10. Please review!"
        static let movieDeletion = "Are you sure?"
    }
}
