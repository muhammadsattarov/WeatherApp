//
//  HourlyCollectionViewCell.swift
//  WeatherDemo
//
//  Created by user on 30/04/24.
//

import UIKit
import SDWebImage

class HourlyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HourlyCollectionViewCell"
    
    private let imageOfView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.text = "12"
        label.textAlignment = .center
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        label.text = "22º"
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.1)
        setup()
        setConstrains()

    }
    
    func configure(with model: Hourly, icon: String) {
        let hourForDate = Date(timeIntervalSince1970: Double(model.dt)).getHourForDate()
        timeLabel.text = hourForDate
        tempLabel.text = String(format: "%.f", model.temp) + "º"
        DispatchQueue.main.async { [weak self] in
            self?.imageOfView.sd_setImage(with: URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png"))

        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
    }
    
}


private extension HourlyCollectionViewCell {
    func setup() {
        contentView.addSubview(imageOfView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(tempLabel)
    }
    
    func setConstrains() {
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            timeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            timeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            timeLabel.heightAnchor.constraint(equalToConstant: 35),
            
            imageOfView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            imageOfView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageOfView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageOfView.heightAnchor.constraint(equalToConstant: 40),
            
            tempLabel.topAnchor.constraint(equalTo: imageOfView.bottomAnchor),
            tempLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            tempLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            tempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
