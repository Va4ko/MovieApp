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
        movieListViewController.title = "Movies"
        self.navigationController?.pushViewController(movieListViewController, animated: true)
    }
    
    @IBAction func addMovieBtnTapped(_ sender: Any) {
        let createMovieViewController = CreateMovieViewController(nibName: "CreateMovieViewController", bundle: nil)
        createMovieViewController.title = "Add"
        
        let navigationController = UINavigationController(rootViewController: createMovieViewController)
        present(navigationController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        showMoviesBtn.setBtnUI()
        showMoviesBtn.setTitle("Show movies", for: .normal)
        
        addMovieBtn.setBtnUI()
        addMovieBtn.setTitle("Add movie", for: .normal)
        
        mainImage.image = UIImage(named: "mainImage")
        mainImage.contentMode = .scaleAspectFit
    }
    
}

