//
//  WeatherData.swift
//  WeatherNow
//
//  Created by CHUBBY on 2022/06/20.
//

import Foundation

struct WeatherDataList: Decodable {
    let list: [WeatherData]
}

struct WeatherData: Decodable {
    let id: Int
    let name: String
    let weather: [Weather]
    let main: Main
    let wind: Wind
}

struct Weather: Decodable {
    let description: String
    let icon: String
}

struct Main: Decodable {
    let temp: Double
    let feelslike: Double
    let minTemp: Double
    let maxTemp: Double
    let pressure: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelslike = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
        case pressure, humidity
    }
}

struct Wind: Decodable {
    let speed: Double
}
