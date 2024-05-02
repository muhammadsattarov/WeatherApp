//
//  HomeViewController.swift
//  WeatherDemo
//
//  Created by user on 30/04/24.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    
    private let gradient = GradientView(from: .top, to: .bottom, startColor: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), endColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        
    private var locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    private var longitude: CLLocationDegrees?
    private var latitude: CLLocationDegrees?
    
    private let activityIndicator: UIActivityIndicatorView = {
        let slider = UIActivityIndicatorView()
        slider.style = .medium
        return slider
    }()
    
    private var currentWeather: OneCallWeather?
//    private var hourlyWeather: [Current] = []
    private var dailyWeather: [Daily]?
    private var type: String?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
        setUpLocationManager()
    }
    
    private func setupView() {
        view.addSubview(gradient)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpLocationManager()
    }
    
    private func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - CollectionView Settings
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: view.frame.width-40,
                                 height: 60)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.showsVerticalScrollIndicator = false
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
        collectionView.register(HomeDailyCollectionViewCell.self,
                                forCellWithReuseIdentifier: HomeDailyCollectionViewCell.identifier)
        collectionView.register(HomeCurrentWeatherView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HomeCurrentWeatherView.identifier)
        collectionView.register(HomeHourlyCollectionView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HomeHourlyCollectionView.identifier)
        collectionView.backgroundColor = .clear
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
        gradient.frame = view.bounds
        activityIndicator.center = view.center
    }
    
    private func showSpinner() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
    }
    
    private func hideSpinner() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
        return currentWeather?.daily.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeDailyCollectionViewCell.identifier, for: indexPath) as? HomeDailyCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let currentWeather {
            let daily = currentWeather.daily[indexPath.row]
            let icon = currentWeather.daily[indexPath.row].weather[0]
            cell.configure(with: daily,
                           icon: icon.icon)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Header View and horizontal collectionView
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        if indexPath.section == 1 {
            let hourlyCollection = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                   withReuseIdentifier: HomeHourlyCollectionView.identifier,
                                                                                   for: indexPath) as! HomeHourlyCollectionView
            if let currentWeather {
                let weather = currentWeather.hourly
                    hourlyCollection.configure(with: weather)
            }
            return hourlyCollection
        }
        let currentView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: HomeCurrentWeatherView.identifier,
                                                                               for: indexPath) as! HomeCurrentWeatherView
        if let currentWeather {
            let type = currentWeather.current.weather[indexPath.row].descriptionWeather
            currentView.configure(with: currentWeather, type: type)
        }
        return currentView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: view.frame.width,
                          height: view.frame.height/3.5)
        }
        return CGSize(width: view.frame.width,
                      height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 1 {
            return .init(top: 20, left: 0, bottom: 10, right: 0)
        }
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    
    func requestWeatherForLocation() {
        guard let currentLocation = currentLocation else { return }
        
        let lon = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude
        
        print("long", lon)
        print("lat", lat)
      
        self.latitude = lat
        self.longitude = lon

        APIManager.shared.fetchOneCallWeather(lat: lat, lon: lon) { [weak self] result in
            switch result {
            case .success(let data):
                self?.currentWeather = data
                self?.dailyWeather = data.daily
                print("Data -----", data)
                DispatchQueue.main.async {
                    self?.collectionView?.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
