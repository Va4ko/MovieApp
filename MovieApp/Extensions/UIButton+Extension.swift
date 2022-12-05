//
//  UITextField+Extension.swift
//  MovieApp
//
//  Created by Ivan Ivanov on 2.12.22.
//

import UIKit

extension UIButton {
    func setBtnUI() {
        let btn = self
        btn.layer.cornerRadius = 15
        btn.backgroundColor = UIColor(named: "IntroScreenBtnColor")
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitleColor(UIColor.purple, for: .highlighted)
    }
}
