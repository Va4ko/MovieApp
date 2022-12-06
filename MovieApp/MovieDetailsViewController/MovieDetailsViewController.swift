//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Ivan Ivanov on 2.12.22.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let edit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editMovie))
        let delete = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteMovie))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapCancelBtn))
        
        navigationItem.rightBarButtonItems = [delete, edit]
        
    }
    
    @objc func editMovie() {
        
        let editMovieViewController = CreateMovieViewController(nibName: "CreateMovieViewController", bundle: nil)
        editMovieViewController.title = "Edit"
//        editMovieViewController.btnTitle = "Edit Movie"
        editMovieViewController.isEditMode = true
        
        navigationController?.pushViewController(editMovieViewController, animated: true)
        
    }
    
    @objc func didTapCancelBtn() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func deleteMovie() {
        
    }


}
