//
//  WeatherViewController.swift
//  WeatherNow
//
//  Created by CHUBBY on 2022/06/20.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var weatherDatas: [WeatherData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setData()
        self.setTableView()
        self.activityIndicator.startAnimating()
    }
    
    func setData() {
        let networkManager = NetworkManager()
        networkManager.fetchWeather { result in
            switch result {
            case .success(let weatherData):
                self.weatherDatas = weatherData
                DispatchQueue.main.async {
                    self.weatherTableView.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func setTableView() {
        self.weatherTableView.dataSource = self
        self.weatherTableView.delegate = self
    }
}

extension WeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as? WeatherTableViewCell else { return UITableViewCell() }
        let weather = self.weatherDatas[indexPath.row]
        cell.configureCell(with: weather)
        return cell
    }
}

extension WeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" {
            guard let weatherDetailVC = segue.destination as? WeatherDetailViewController, let indexPath = sender as? IndexPath else { return }
            weatherDetailVC.weatherDetail = self.weatherDatas[indexPath.row]
        }
    }
}
