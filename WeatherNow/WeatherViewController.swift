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
        var networkManager = NetworkManager()
        networkManager.delegate = self
        networkManager.fetchWeather()
    }
    
    func setTableView() {
        self.weatherTableView.dataSource = self
        self.weatherTableView.delegate = self
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func stopAndHideActivityIndicator() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
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

extension WeatherViewController: NetworkManagerDelegate {
    
    func didFailWithError(_ response: HTTPURLResponse) {
        switch response.statusCode {
        case 401:
            DispatchQueue.main.async {
                self.showAlert(message: NetworkError.invalidAPIKey.message)
                self.stopAndHideActivityIndicator()
            }
        case 404:
            DispatchQueue.main.async {
                self.showAlert(message: NetworkError.invalidQueryParameters.message)
                self.stopAndHideActivityIndicator()
            }
        case 429:
            DispatchQueue.main.async {
                self.showAlert(message: NetworkError.surpassingLimitOfAPICalls.message)
                self.stopAndHideActivityIndicator()
            }
        case 500, 502, 503, 504:
            DispatchQueue.main.async {
                self.showAlert(message: NetworkError.serverError.message)
                self.stopAndHideActivityIndicator()
            }
        default:
            DispatchQueue.main.async {
                self.showAlert(message: "알 수 없는 오류 발생")
                self.stopAndHideActivityIndicator()
            }
        }
    }
    
    func didUpdateWeather(with weatherDatas: [WeatherData]) {
        self.weatherDatas = weatherDatas
        DispatchQueue.main.async {
            self.weatherTableView.reloadData()
            self.stopAndHideActivityIndicator()
        }
    }
}
