//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Ivan Ivanov on 2.12.22.
//

import UIKit

private let reuseIdentifier = "MovieCell"

enum CellIdentifiers: String {
    case MovieCollectionViewCell = "MovieCollectionViewCell"
    case AddMovieCollectionViewCell = "AddMovieCollectionViewCell"
}

class MovieListViewController: UICollectionViewController {
    
    let image = UIImage(named: "Avatar")
    let image2 = UIImage(named: "TheMatrix")
    let image3 = UIImage(named: "StarWars")
    
    var images: [UIImage] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addMovieCollectionCell = UINib(nibName: CellIdentifiers.AddMovieCollectionViewCell.rawValue, bundle: nil)
        collectionView.register(addMovieCollectionCell, forCellWithReuseIdentifier: CellIdentifiers.AddMovieCollectionViewCell.rawValue)
        
        let movieCollectionCell = UINib(nibName: CellIdentifiers.MovieCollectionViewCell.rawValue, bundle: nil)
        collectionView.register(movieCollectionCell, forCellWithReuseIdentifier: CellIdentifiers.MovieCollectionViewCell.rawValue)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMovie))
        
        setCollectionViewLayout()
        
        images = [image!, image2!, image3!, image!, image2!]
        
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
        createMovieViewController.title = "Add"
        createMovieViewController.btnTitle = "Add Movie"
        
        let navigationController = UINavigationController(rootViewController: createMovieViewController)
        present(navigationController, animated: true)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == images.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.AddMovieCollectionViewCell.rawValue, for: indexPath) as! AddMovieCollectionViewCell
            return cell
        } else {
            let imagee = images[indexPath.item]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.MovieCollectionViewCell.rawValue, for: indexPath) as! MovieCollectionViewCell
                    cell.moviePoster.image = imagee
            return cell
        }
        
        
        
        
        
        
        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.AddMovieCollectionViewCell.rawValue, for: indexPath)
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.MovieCollectionViewCell.rawValue, for: indexPath)
        //////
//        let imagee = images[indexPath.item]
////
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.MovieCollectionViewCell.rawValue, for: indexPath) as! MovieCollectionViewCell
//        cell.moviePoster.image = imagee
        
        
        
//        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.cellForItem(at: indexPath) is AddMovieCollectionViewCell {
            addMovie()
        } else {
                    let movieDetailsViewController = MovieDetailsViewController(nibName: "MovieDetailsViewController", bundle: nil)
                    movieDetailsViewController.title = "Details \(indexPath.item)"
                    let navigationController = UINavigationController(rootViewController: movieDetailsViewController)
                    present(navigationController, animated: true)
        }
        
        
//        let movieDetailsViewController = MovieDetailsViewController(nibName: "MovieDetailsViewController", bundle: nil)
//        movieDetailsViewController.title = "Details \(indexPath.item)"
//        let navigationController = UINavigationController(rootViewController: movieDetailsViewController)
//        present(navigationController, animated: true)
    }
    
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
