//
//  UITextField+Extension.swift
//  MovieApp
//
//  Created by Ivan Ivanov on 6.12.22.
//

import UIKit

extension UITextField {
    func setupTextFields(placeHolder: String) {
        layer.cornerRadius = 15
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        layer.masksToBounds = true
        attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
    func isMoreThanThree() -> Bool {
        guard let text = self.text else { return false }
        
        if text.count < 3 {
            return false
        }
        return true
    }
    
}
