//
//  NetworkManager.swift
//  WeatherNow
//
//  Created by CHUBBY on 2022/06/20.
//

import Foundation

enum NetworkError: Error {
    case invalidAPIKey
    case invalidQueryParameters
    case surpassingLimitOfAPICalls
    case serverError
    
    var message: String {
        switch self {
        case .invalidAPIKey:
            return "API Key가 아직 활성화되지 않았거나 유효하지 않은 API key입니다."
        case .invalidQueryParameters:
            return "Query parameter를 다시 확인해주세요."
        case .surpassingLimitOfAPICalls:
            return "API 호출 횟수 한도를 초과했습니다."
        case .serverError:
            return "Server 에러가 발생했습니다."
        }
    }
}

protocol NetworkManagerDelegate {
    func didUpdateWeather(with weatherDatas: [WeatherData])
    func didFailWithError(_ response: HTTPURLResponse)
}

struct NetworkManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/group?"
    let apiKey = Bundle.main.apiKey
    let queryOption = "units=metric&lang=kr"
    
    var delegate: NetworkManagerDelegate?
  
    func getCityString() -> String {
        var cityArray = [Int]()
        City.allCases.forEach { cityArray.append($0.rawValue) }
        let cityString = cityArray.map { "\($0)"}.joined(separator: ",")
        return cityString
    }
    
    func fetchWeather() {
        let cities = self.getCityString()
        let urlString = "\(weatherURL)&id=\(cities)&appid=\(apiKey)&\(queryOption)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        guard let url = URL(string: urlString)  else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else { return }
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
    
    func parseJSON(_ data: Data) -> [WeatherData]? {
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
