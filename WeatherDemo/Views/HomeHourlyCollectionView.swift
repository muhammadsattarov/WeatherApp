//
//  HomeHourlyCollectionView.swift
//  WeatherDemo
//
//  Created by user on 30/04/24.
//

import UIKit

class HomeHourlyCollectionView: UICollectionReusableView {
    
    static let identifier = "HomeHourlyCollectionView"
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 60, height: 120)
        layout.sectionInset = .init(top: 5, left: 10, bottom: 5, right: 10)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(HourlyCollectionViewCell.self,
                            forCellWithReuseIdentifier: HourlyCollectionViewCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    private var weatherModel: [Hourly]?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setConstrains()
    }
    
    func configure(with model: [Hourly]) {
        self.weatherModel = model
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func setup() {
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        backgroundColor = .clear
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Constrains
extension HomeHourlyCollectionView {
    private func setConstrains() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HomeHourlyCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherModel?.count ?? 0
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.identifier, for: indexPath) as! HourlyCollectionViewCell
        if let weatherModel {
            let icon = weatherModel[indexPath.row].weather[0]
            cell.configure(with: weatherModel[indexPath.row],
                           icon: icon.icon)
        }
        return cell
    }
    
    
}
