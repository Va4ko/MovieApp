//
//  Utils.swift
//  MovieApp
//
//  Created by Ivan Ivanov on 6.12.22.
//

import UIKit

/// Show alert viewcontroller with message
func popAlert(message: String, onComplete: @escaping () -> Void) {
    let alert = UIAlertController(title: "Attention", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        alert.dismiss(animated: true, completion: {
            onComplete()
        })
    }))
    let currentViewController = currentVC()
    currentViewController.present(alert, animated: true)
}

/// Get current viewcontroller
public func currentVC() -> UIViewController {
    let keyWindow = UIWindow.key
    var currentViewCtrl: UIViewController = keyWindow!.rootViewController!
    while (currentViewCtrl.presentedViewController != nil) {
        currentViewCtrl = currentViewCtrl.presentedViewController!
    }
    return currentViewCtrl
}
