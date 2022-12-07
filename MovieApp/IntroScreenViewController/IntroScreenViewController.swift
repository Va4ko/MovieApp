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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        showMoviesBtn.setBtnUI()
        showMoviesBtn.setTitle(Constants.Titles.introScreenShowMoviesBtnTitle, for: .normal)
        
        addMovieBtn.setBtnUI()
        addMovieBtn.setTitle(Constants.Titles.introScreenAddMovieBtnTitle, for: .normal)
        
        mainImage.image = UIImage(named: "mainImage")
    }
    
}

