//
//  HomeDailyCollectionViewCell.swift
//  WeatherDemo
//
//  Created by user on 30/04/24.
//

import UIKit
import SDWebImage

class HomeDailyCollectionViewCell: UICollectionViewCell {
       static let identifier = "HomeDailyCollectionViewCell"
    
    private let imageOfView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let dayNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        label.text = "Today"
        label.textAlignment = .center
        return label
    }()
    
    private let minTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
        label.text = "22º"
        label.textAlignment = .center
        return label
    }()
    
    private let maxTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
        label.text = "26º"
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setConstrains()
    }
    
    func configure(with model: Daily, icon: String) {
        dayNameLabel.text = Date(timeIntervalSince1970: Double(model.dt)).getDayForDate()
        minTempLabel.text = String(format: "%.f", model.temp.min) + "º"
        maxTempLabel.text = String(format: "%.f", model.temp.max) + "º"
        DispatchQueue.main.async { [weak self] in
            self?.imageOfView.sd_setImage(with: URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png"))
        }
    }
    
    private func setup() {
        contentView.addSubview(imageOfView)
        contentView.addSubview(dayNameLabel)
        contentView.addSubview(minTempLabel)
        contentView.addSubview(maxTempLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.1)
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
    
}

// MARK: - Constrains
extension HomeDailyCollectionViewCell {
    private func setConstrains() {
        let size: CGFloat = 50
        let imageSize: CGFloat = contentView.frame.height-20
        NSLayoutConstraint.activate([
            dayNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dayNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            dayNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            maxTempLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            maxTempLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            maxTempLabel.widthAnchor.constraint(equalToConstant: size),
            
            minTempLabel.rightAnchor.constraint(equalTo: maxTempLabel.leftAnchor),
            minTempLabel.widthAnchor.constraint(equalToConstant: size),
            minTempLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            imageOfView.rightAnchor.constraint(equalTo: minTempLabel.leftAnchor, constant: -20),
            imageOfView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageOfView.widthAnchor.constraint(equalToConstant: imageSize),
            imageOfView.heightAnchor.constraint(equalToConstant: imageSize)
        ])
    }
}
