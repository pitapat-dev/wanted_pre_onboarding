//
//  WeatherDataManager.swift
//  WeatherNow
//
//  Created by CHUBBY on 2022/06/20.
//

import Foundation

struct WeatherDataManager {
    
    func getCityName(of weather: WeatherData) -> String {
        guard let cityName = City(rawValue: weather.id) else { return "" }
        return String(describing: cityName)
    }
    
    func getDescription(of weather: WeatherData) -> String {
        let description = weather.weather[0].description
        return String(describing: description)
    }
    
    func getCurrentTemp(of weather: WeatherData) -> String {
        let currentTemp = String(format: "%.0f", weather.main.temp)
        return currentTemp + "°C"
    }
    
    func getMaxTemp(of weather: WeatherData) -> String {
        let maxTemp = String(format: "%.1f", weather.main.maxTemp)
        return maxTemp + "°C"
    }
    
    func getMinTemp(of weather: WeatherData) -> String {
        let minTemp = String(format: "%.1f", weather.main.minTemp)
        return minTemp + "°C"
    }
    
    func getHumidity(of weather: WeatherData) -> String {
        return "\(weather.main.humidity)%"
    }
    
    func getFeelsLike(of weather: WeatherData) -> String {
        let feelsLike = String(format: "%.1f", weather.main.feelslike)
        return feelsLike + "°C"
    }
    
    func getPressure(of weather: WeatherData) -> String {
        return "\(weather.main.pressure) hPa"
    }
    
    func getWindSpeed(of weather: WeatherData) -> String {
        let windSpeed = String(format: "%.1f", weather.wind.speed)
        return windSpeed + " m/s"
    }
    
}
