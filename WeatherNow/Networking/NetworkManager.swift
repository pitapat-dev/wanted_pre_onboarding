//
//  NetworkManager.swift
//  WeatherNow
//
//  Created by CHUBBY on 2022/06/20.
//

import Foundation

protocol NetworkManagerDelegate {
    func didUpdateWeather(with weatherDatas: [WeatherData])
    func didFailWithError(_ response: HTTPURLResponse)
}

struct NetworkManager {
    
    var delegate: NetworkManagerDelegate?
  
    private func getCityString() -> String {
        var cityArray = [Int]()
        City.allCases.forEach { cityArray.append($0.rawValue) }
        let cityString = cityArray.map { "\($0)"}.joined(separator: ",")
        return cityString
    }
    
    func fetchWeather() {
        let cities = "id=\(self.getCityString())"
        let urlString = "\(WeatherAPI.weatherURL)&\(cities)&\(WeatherAPI.apiKey)&\(WeatherAPI.queryOption)"
        performRequest(with: urlString)
    }
    
    private func performRequest(with urlString: String) {
        guard let url = URL(string: urlString)  else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data,
                    let response = response as? HTTPURLResponse,
                    error == nil else { return }
                switch response.statusCode {
                case 200:
                    guard let weatherData = self.parseJSON(data) else { return }
                    self.delegate?.didUpdateWeather(with: weatherData)
                case 401, 404, 429, 500, 502, 503, 504:
                    self.delegate?.didFailWithError(response)
                default:
                    print("Error: 알 수 없는 오류 발생")
                }
        }
        task.resume()
    }
    
    private func parseJSON(_ data: Data) -> [WeatherData]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherDataList.self, from: data)
            let weatherData = decodedData.list
            return weatherData
        } catch {
            print("Error : \(error.localizedDescription)")
            return nil
        }
    }
}
