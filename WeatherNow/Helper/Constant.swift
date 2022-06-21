//
//  Constant.swift
//  WeatherNow
//
//  Created by CHUBBY on 2022/06/21.
//

import UIKit

// MARK: - Network

public enum WeatherAPI {
    static let weatherURL = "https://api.openweathermap.org/data/2.5/group?"
    static let apiKey = "appid=\(Bundle.main.apiKey)"
    static let queryOption = "units=metric&lang=kr"
}

// MARK: - Cell Identifier

public enum CellIdentifier {
    static let weatherTableViewCell = "WeatherTableViewCell"
}

// MARK: - Segue Identifier

public enum SegueIdentifier {
    static let goToDetail = "goToDetail"
}

// MARK: - Image Cache

public enum ImageCache {
    static let cache: NSCache<NSString, UIImage> = NSCache()
}


