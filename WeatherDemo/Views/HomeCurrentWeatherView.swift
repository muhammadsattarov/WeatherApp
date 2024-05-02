//
//  HomeCurrentWeatherView.swift
//  WeatherDemo
//
//  Created by user on 30/04/24.
//

import UIKit

class HomeCurrentWeatherView: UICollectionReusableView {
    static let identifier = "HomeCurrentWeatherView"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 35, weight: .semibold)
        label.textColor = .white
        label.text = "Location"
        label.textAlignment = .center
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 60, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "- -"
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "- -"
        return label
    }()
    
    private let minMaxTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "- / -"
        return label
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setConstrains()
        backgroundColor = .clear
    }
    
    func configure(with model: OneCallWeather, type: String) {
        guard let daily = model.daily.first else { return }
        nameLabel.text = model.timezone.deletingPrefix()
        tempLabel.text = String(format: "%.f", model.current.temp) + "º"
        typeLabel.text = type
        minMaxTempLabel.text = "L:\(String(format: "%.f", daily.temp.min) + "º") / H:\(String(format: "%.f", daily.temp.max) + "º")"
    }
    
    private func setup() {
        addSubview(nameLabel)
        addSubview(tempLabel)
        addSubview(typeLabel)
        addSubview(minMaxTempLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Constrains
extension HomeCurrentWeatherView {
    private func setConstrains() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),

            tempLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            tempLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            minMaxTempLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 20),
            minMaxTempLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -5),
            
            typeLabel.topAnchor.constraint(equalTo: minMaxTempLabel.bottomAnchor, constant: 10),
            typeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
            typeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -40)
        ])
    }
}
