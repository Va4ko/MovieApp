//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Ivan Ivanov on 2.12.22.
//

import UIKit

enum CellIdentifiers: String {
    case MovieCollectionViewCell = "MovieCollectionViewCell"
    case AddMovieCollectionViewCell = "AddMovieCollectionViewCell"
}

class MovieListViewController: UICollectionViewController {
    
    weak var movieDelegate: MovieDetailsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMovie))
        
        registerCells()
        
        setCollectionViewLayout()
        
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
    
    @objc func addMovie() {
        let createMovieViewController = CreateMovieViewController(nibName: "CreateMovieViewController", bundle: nil)
        
        let navigationController = UINavigationController(rootViewController: createMovieViewController)
        present(navigationController, animated: true)
        
        createMovieViewController.isDismissed = { [weak self] in
            CoreDataManager.shared.fetchMovies { movies in
                MovieDataSource.shared.movies = movies
                self?.collectionView.reloadData()
            }
            
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let movies = MovieDataSource.shared.movies else { return 1 }
        if movies.count < 6 {
            return movies.count + 1
        } else {
            return 6
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let movies = MovieDataSource.shared.movies {
            if indexPath.item == movies.count {
                navigationItem.rightBarButtonItem?.isEnabled = true
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.AddMovieCollectionViewCell.rawValue, for: indexPath) as! AddMovieCollectionViewCell
                return cell
            } else {
                navigationItem.rightBarButtonItem?.isEnabled = false
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.MovieCollectionViewCell.rawValue, for: indexPath) as! MovieCollectionViewCell
                let movie = movies[indexPath.item]
                cell.configureCell(movie: movie)
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.cellForItem(at: indexPath) is AddMovieCollectionViewCell {
            addMovie()
        } else {
            guard let movies = MovieDataSource.shared.movies else { return }
            let movie = movies[indexPath.item]
            let movieDetailsViewController = MovieDetailsViewController(nibName: "MovieDetailsViewController", bundle: nil)
            
            movieDelegate = movieDetailsViewController
            movieDelegate?.movieData(movie: movie)
            
            let navigationController = UINavigationController(rootViewController: movieDetailsViewController)
            present(navigationController, animated: true)
            
            movieDetailsViewController.isDismissed = { [weak self] in
                CoreDataManager.shared.fetchMovies { movies in
                    MovieDataSource.shared.movies = movies
                }
                self?.collectionView.reloadData()
            }
        }
        
    }
    
}
