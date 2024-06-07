//
//  Weather.swift
//  OpenWeatherProject
//
//  Created by 권대윤 on 6/7/24.
//

import UIKit

struct WeatherData: Codable {
    var weather: [Weather]?
    var main: Main?
    var wind: Wind?
    var date: Int?
    
    enum CodingKeys: String, CodingKey {
        case main
        case weather
        case wind
        case date = "dt"
    }
}

struct Weather: Codable {
    var icon: String?
    var main: String?
    var description: String?
}

struct Main: Codable {
    var temp: Double?
    var humidity: Double?
}

struct Wind: Codable {
    var speed: Double?
}


