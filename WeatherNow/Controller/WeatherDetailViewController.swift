//
//  WeatherDetailViewController.swift
//  WeatherNow
//
//  Created by CHUBBY on 2022/06/20.
//

import UIKit

final class WeatherDetailViewController: UITableViewController {
    
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var currentTempCell: UITableViewCell!
    @IBOutlet weak var feelsLikeCell: UITableViewCell!
    @IBOutlet weak var maxTempCell: UITableViewCell!
    @IBOutlet weak var minTempCell: UITableViewCell!
    @IBOutlet weak var humidityCell: UITableViewCell!
    @IBOutlet weak var windSpeedCell: UITableViewCell!
    @IBOutlet weak var pressureCell: UITableViewCell!
    
    var weatherDetail: WeatherData?
    let weatherDataManager = WeatherDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    private func setTableView() {
        guard let weather = weatherDetail else { return }
        self.title = weatherDataManager.getCityName(of: weather)
        self.currentTempCell.detailTextLabel?.text = weatherDataManager.getCurrentTemp(of: weather)
        self.feelsLikeCell.detailTextLabel?.text = weatherDataManager.getFeelsLike(of: weather)
        self.maxTempCell.detailTextLabel?.text = weatherDataManager.getMaxTemp(of: weather)
        self.minTempCell.detailTextLabel?.text = weatherDataManager.getMinTemp(of: weather)
        self.humidityCell.detailTextLabel?.text = weatherDataManager.getHumidity(of: weather)
        self.windSpeedCell.detailTextLabel?.text = weatherDataManager.getWindSpeed(of: weather)
        self.pressureCell.detailTextLabel?.text = weatherDataManager.getPressure(of: weather)
        self.weatherIconImageView.loadImage(weather.weather[0].icon)
        self.descriptionLabel.text = weatherDataManager.getDescription(of: weather)
    }
    
}
