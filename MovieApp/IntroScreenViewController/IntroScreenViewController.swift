//
//  IntroScreenViewController.swift
//  MovieApp
//
//  Created by Ivan Ivanov on 2.12.22.
//

import UIKit

class IntroScreenViewController: UIViewController {
    
    @IBOutlet weak var showMoviesBtn: UIButton!
    @IBOutlet weak var addMovieBtn: UIButton!
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBAction func showMoviesBtnTapped(_ sender: Any) {
        let movieListViewController = MovieListViewController(nibName: "MovieListViewController", bundle: nil)
        movieListViewController.title = Constants.Titles.movieListViewControllerTitle
        self.navigationController?.pushViewController(movieListViewController, animated: true)
    }
    
    @IBAction func addMovieBtnTapped(_ sender: Any) {
        let createMovieViewController = CreateMovieViewController(nibName: "CreateMovieViewController", bundle: nil)
        
        let navigationController = UINavigationController(rootViewController: createMovieViewController)
        present(navigationController, animated: true)
        
        createMovieViewController.isDismissed = { [weak self] in
            self?.getMovies()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMovies()
    }
    
    private func setupUI() {
        showMoviesBtn.setBtnUI()
        showMoviesBtn.setTitle(Constants.Titles.introScreenShowMoviesBtnTitle, for: .normal)
        
        addMovieBtn.setBtnUI()
        addMovieBtn.setTitle(Constants.Titles.introScreenAddMovieBtnTitle, for: .normal)
        
        mainImage.image = UIImage(named: "mainImage")
    }
    
    private func getMovies() {
        CoreDataManager.shared.fetchMovies { movies in
            MovieDataSource.shared.movies = movies
            self.dissableAddBtnIfNeeded()
        }
    }
    
    private func dissableAddBtnIfNeeded() {
        if MovieDataSource.shared.movies?.count == 6 {
            addMovieBtn.isEnabled = false
        } else {
            addMovieBtn.isEnabled = true
        }
    }
    
}
