//
//  NetworkManager.swift
//  WeatherNow
//
//  Created by CHUBBY on 2022/06/20.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case networkingError
    case parseError
    
    var message: String {
        switch self {
        case .invalidURL:
            return "URL을 확인해주세요."
        case .networkingError:
            return "네트워크 상태를 확인해주세요."
        case .parseError:
            return "데이터 파싱에 실패하였습니다."
        }
    }
}

struct NetworkManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/group?"
    let apiKey = Bundle.main.apiKey
    let queryOption = "units=metric&lang=kr"
    
    typealias NetworkCompletion = (Result<[WeatherData], NetworkError>) -> Void
    
    func getCityString() -> String {
        var cityArray = [Int]()
        City.allCases.forEach { cityArray.append($0.rawValue) }
        let cityString = cityArray.map { "\($0)"}.joined(separator: ",")
        return cityString
    }
    
    func fetchWeather(completion: @escaping NetworkCompletion) {
        let cities = self.getCityString()
        let urlString = "\(weatherURL)&id=\(cities)&appid=\(apiKey)&\(queryOption)"
        performRequest(with: urlString) { result in
            completion(result)
        }
    }
    
    func performRequest(with urlString: String, completion: @escaping NetworkCompletion) {
        guard let url = URL(string: urlString)  else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else { return }
            switch response.statusCode {
            case 200...299:
                guard let weatherData = self.parseJSON(data) else { return }
                completion(.success(weatherData))
            case 400...499:
                print("Error: \(NetworkError.invalidURL.message)")
                completion(.failure(.invalidURL))
            case 500...599:
                print("Error: \(NetworkError.networkingError.message)")
                completion(.failure(.networkingError))
            default:
                print("Unknown Error")
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
            print("Error : \(NetworkError.parseError.message)")
            return nil
        }
    }
}
