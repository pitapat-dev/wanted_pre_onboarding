//
//  UIImageViewExtension.swift
//  WeatherNow
//
//  Created by CHUBBY on 2022/06/20.
//

import UIKit

let imageCache: NSCache<NSString, UIImage> = NSCache()

extension UIImageView {
    
    func loadImage(_ icon: String) {
        let imageURL = "http://openweathermap.org/img/wn/\(icon)@2x.png"
        let url = URL(string: imageURL)!
        if let cacheImage = imageCache.object(forKey: imageURL as NSString) {
            DispatchQueue.main.async() { [weak self] in
                self?.image = cacheImage
            }
        }
        else {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                guard let data = data, let response = response as? HTTPURLResponse, error == nil else { return }
                if response.statusCode == 200 {
                    guard let image = UIImage(data: data) else { return }
                    DispatchQueue.main.async() { [weak self] in
                        imageCache.setObject(image, forKey: imageURL as NSString)
                        self?.image = image
                    }
                } else {
                    guard let error = error else { return }
                    print("Error: \(error.localizedDescription)")
                }
            }
            task.resume()
        }
    }

}
