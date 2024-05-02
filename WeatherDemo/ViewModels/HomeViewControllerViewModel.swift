//
//  HomeViewControllerViewModel.swift
//  WeatherDemo
//
//  Created by user on 30/04/24.
//

import Foundation
import CoreLocation

//final class HomeViewControllerViewModel {
//    var weatherDetailes: [CurrentWeather] = []
//    
//    var cityName: String?
//    var icon: String?
//    var temperature: String?
//    var type: String?
//    
//    func callWeatherAPIForCurrentLocation(
//        lon: CLLocationDegrees,
//        lat: CLLocationDegrees,
//        completion: @escaping(_ weather: CurrentWeather?, _ errorMessage: String) -> Void
//    ) {
//        WeatherManager(latitude: lat, longitude: lon).getCurrentWeatherData { result in
//            switch result {
//            case .success(let response):
//                completion(response, "")
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    completion(nil, error.localizedDescription)
//                }
//            }
//        }
//    }
//}
