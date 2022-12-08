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
    
    func isMoreThanTen() -> Bool {
        guard let text = self.text else { return false }
        
        if text.count < 10 {
            return false
        }
        return true
    }
}
