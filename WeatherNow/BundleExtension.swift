//
//  BundleExtension.swift
//  WeatherNow
//
//  Created by CHUBBY on 2022/06/20.
//

import Foundation

extension Bundle {
    var apiKey: String {
        guard let file = self.path(forResource: "WeatherAPIKey", ofType: "plist") else { return "" }
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["API_KEY"] as? String else { return "" }
        return key
    }
}
