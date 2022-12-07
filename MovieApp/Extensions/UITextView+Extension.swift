//
//  UITextView+Extension.swift
//  MovieApp
//
//  Created by Ivan Ivanov on 6.12.22.
//

import UIKit

extension UITextView {
    func setupTextView() {
        layer.cornerRadius = 15.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        layer.masksToBounds = true
        layer.backgroundColor = UIColor.white.cgColor
    }
    
    func isValid() -> Bool {
        guard let text = self.text, !text.isEmpty else {
            print("Please fill the field.")
            return false
        }
        return true
    }
    
    func isMoreThanTen() -> Bool {
        guard let text = self.text else { return false }
        
        if text.count < 10 {
            print("Please enter more than 10 characters.")
            return false
        }
        return true
    }
}
