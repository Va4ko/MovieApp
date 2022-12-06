//
//  UIViewController+Extension.swift
//  MovieApp
//
//  Created by Ivan Ivanov on 6.12.22.
//

import UIKit

extension UIViewController {
    /// Hide keyboard when tapped ouside
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
