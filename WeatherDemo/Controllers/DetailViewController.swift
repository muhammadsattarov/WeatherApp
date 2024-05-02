//
//  DetailViewController.swift
//  WeatherDemo
//
//  Created by user on 30/04/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let gradient = GradientView(from: .top, to: .bottom, startColor: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), endColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.addSubview(gradient)
        gradient.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = view.bounds
    }
}
