//
//  UITextField+Extension.swift
//  MovieApp
//
//  Created by Ivan Ivanov on 2.12.22.
//

import UIKit

extension UIButton {
    func setBtnUI() {
        layer.cornerRadius = 15
        backgroundColor = UIColor(named: "IntroScreenBtnColor")
        setTitleColor(UIColor.white, for: .normal)
        setTitleColor(UIColor.purple, for: .highlighted)
    }
}
