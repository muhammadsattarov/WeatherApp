//
//  Date+Extension.swift
//  WeatherDemo
//
//  Created by user on 01/05/24.
//

import Foundation

extension Date {
    func getTimeForDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
    func getHourForDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        return formatter.string(from: self)
    }
    
    func getDayForDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self)
    }
}

extension StringProtocol {
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}


extension String {
    func deletingPrefix() -> String {
        let newString = self.components(separatedBy: "/")
        return newString[1]
    }
    
}
