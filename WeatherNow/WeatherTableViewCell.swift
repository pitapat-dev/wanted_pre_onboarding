//
//  WeatherTableViewCell.swift
//  WeatherNow
//
//  Created by CHUBBY on 2022/06/20.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    
    func configureCell(with weather: WeatherData) {
        let weatherDataManager = WeatherDataManager()
        self.cityNameLabel.text = weatherDataManager.getCityName(of: weather)
        self.currentTempLabel.text = weatherDataManager.getCurrentTemp(of: weather)
        self.weatherIconImageView.loadImage(weather.weather[0].icon)
        self.humidityLabel.text = weatherDataManager.getHumidity(of: weather)
    }
    
}
