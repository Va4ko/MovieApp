//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Ivan Ivanov on 2.12.22.
//

import UIKit

protocol MovieDetailsDelegate: AnyObject {
    func movieData(movie: Movie)
}

enum CellIdentifiers: String {
    case MovieCollectionViewCell = "MovieCollectionViewCell"
    case AddMovieCollectionViewCell = "AddMovieCollectionViewCell"
}

class MovieListViewController: UICollectionViewController {
    
    private var movies: [Movie] = []
    
    weak var movieDelegate: MovieDetailsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMovie))
        
        registerCells()
        
        setCollectionViewLayout()
        
        getMovies()
        
    }
    
    private func registerCells() {
        let addMovieCollectionCell = UINib(nibName: CellIdentifiers.AddMovieCollectionViewCell.rawValue, bundle: nil)
        collectionView.register(addMovieCollectionCell, forCellWithReuseIdentifier: CellIdentifiers.AddMovieCollectionViewCell.rawValue)
        
        let movieCollectionCell = UINib(nibName: CellIdentifiers.MovieCollectionViewCell.rawValue, bundle: nil)
        collectionView.register(movieCollectionCell, forCellWithReuseIdentifier: CellIdentifiers.MovieCollectionViewCell.rawValue)
    }
    
    func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.frame.size.width / 2) - 20, height: 220)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        collectionView.collectionViewLayout = layout
        
    }
    
    private func getMovies() {
        movies = CoreDataManager.shared.fetchMovies()
    }
    
    @objc func addMovie() {
        let createMovieViewController = CreateMovieViewController(nibName: "CreateMovieViewController", bundle: nil)
        
        let navigationController = UINavigationController(rootViewController: createMovieViewController)
        present(navigationController, animated: true)
        
        createMovieViewController.isDismissed = { [weak self] in
            self?.movies = CoreDataManager.shared.fetchMovies()
            self?.collectionView.reloadData()
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count + 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if movies.isEmpty {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.AddMovieCollectionViewCell.rawValue, for: indexPath) as! AddMovieCollectionViewCell
            return cell
        } else if indexPath.item == movies.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.AddMovieCollectionViewCell.rawValue, for: indexPath) as! AddMovieCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.MovieCollectionViewCell.rawValue, for: indexPath) as! MovieCollectionViewCell
            let movie = movies[indexPath.item]
            cell.configureCell(movie: movie)
            return cell
        }
        
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.cellForItem(at: indexPath) is AddMovieCollectionViewCell {
            addMovie()
        } else {
            let movie = movies[indexPath.item]
            let movieDetailsViewController = MovieDetailsViewController(nibName: "MovieDetailsViewController", bundle: nil)
            movieDelegate = movieDetailsViewController
            movieDelegate?.movieData(movie: movie)
            let navigationController = UINavigationController(rootViewController: movieDetailsViewController)
            present(navigationController, animated: true)
            
            movieDetailsViewController.isDismissed = { [weak self] in
                self?.movies = CoreDataManager.shared.fetchMovies()
                self?.collectionView.reloadData()
            }
        }
        
    }
    
}
