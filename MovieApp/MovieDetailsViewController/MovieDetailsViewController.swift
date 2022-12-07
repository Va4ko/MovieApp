//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Ivan Ivanov on 2.12.22.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    private var movie: Movie?
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var longDescriptionView: UITextView!
    
    var isDismissed: (() -> Void)?
    
    weak var movieDelegate: MovieDetailsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let edit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editMovie))
        let delete = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteMovie))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapCancelBtn))
        
        navigationItem.rightBarButtonItems = [delete, edit]
        
        setMovieInfo()
    }
    
    @objc func editMovie() {
        
        let editMovieViewController = CreateMovieViewController(nibName: "CreateMovieViewController", bundle: nil)
        editMovieViewController.isEditMode = true
        
        movieDelegate = editMovieViewController
        guard let movie = self.movie else { return }
        movieDelegate?.movieData(movie: movie)
        
        navigationController?.pushViewController(editMovieViewController, animated: true)
        
    }
    
    @objc func didTapCancelBtn() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func deleteMovie() {
        popAlert(message: Constants.AlertMessages.movieDeletion) {
            guard let movie = self.movie else { return }
            CoreDataManager.shared.deleteMovie(movie: movie)
            self.dismiss(animated: true) {
                self.isDismissed?()
            }
        }
    }
    
    private func setMovieInfo() {
        guard let movie = movie else { return }
        guard let imageData = movie.poster else { return }
        poster.image = UIImage(data: imageData)
        titleLabel.text = movie.title
        dateLabel.text = movie.releaseDate
        genreLabel.text = movie.genre
        shortDescriptionLabel.text = movie.shortAbout
        longDescriptionView.text = movie.longAbout
    }
    
}

extension MovieDetailsViewController : MovieDetailsDelegate {
    func movieData(movie: Movie) {
        self.movie = movie
    }
}
