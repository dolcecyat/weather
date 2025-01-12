//
//  WeatherManager.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 29.11.2024.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherData) 
    func didFailWithError(error:Error)
}

class WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let apiKey = ["X-Yandex-API-Key": "87975d2c-299f-4093-8202-4e7549aac07a"]
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=\(latitude)&lon=\(longitude)&lang=ru_RU&limit=7&hours=true&extra=true"
        
        let request = URLHelper.makeSafeGetRequest(url: urlString, parameters: apiKey)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            
            let data = URLHelper.checkForNil(data: data, response: response, error: error)
            
            if let weatherData = URLHelper.decodeJson(WeatherData.self , from: data) {
                self?.delegate?.didUpdateWeather(weather: weatherData)
            }
        }
        task.resume()
    }
}
