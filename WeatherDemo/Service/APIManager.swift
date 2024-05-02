//
//  WeatherService.swift
//  WeatherDemo
//
//  Created by user on 30/04/24.
//

import Foundation
import CoreLocation

class APIManager {
    
    static let shared = APIManager()
    
    func fetchOneCallWeather(lat: CLLocationDegrees,
                             lon: CLLocationDegrees,
                             completion: @escaping (Result<OneCallWeather, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.host)/data/3.0/onecall?lat=\(lat)&lon=\(lon)&appid=\(Constants.key)&units=metric") else { return }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let responce = try JSONDecoder().decode(OneCallWeather.self, from: data)
                completion(.success(responce))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

// https://api.openweathermap.org/data/3.0/onecall?lat=37.785834&lon=-122.406417&appid=ef62e4995bcdfe763c409b749977eeba&units=standard
