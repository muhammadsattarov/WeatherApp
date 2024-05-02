//
//  Double+Extension.swift
//  WeatherDemo
//
//  Created by user on 30/04/24.
//

import Foundation

extension Double {
    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: self)

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = .medium

        return dateFormatter.string(from: date)
    }
}
