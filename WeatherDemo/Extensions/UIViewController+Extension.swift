//
//  UIViewController.swift
//  WeatherDemo
//
//  Created by user on 30/04/24.
//

import UIKit

extension UIViewController {
    public func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
