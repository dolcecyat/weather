//
//  WeatherManager.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 29.11.2024.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherData) 
    func didFailWithError(error:Error)
}

class WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let apiKey = "87975d2c-299f-4093-8202-4e7549aac07a"
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=\(latitude)&lon=\(longitude)&lang=ru_RU&limit=7&hours=true&extra=true"
        
        guard let url = URL(string: urlString) else {
            print("Некорректный URL")
            return
        }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["X-Yandex-API-Key" : apiKey]
        print(url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let error = error {
                print("Ошибка запроса: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("Нет данных")
                return
            }
            do {
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                self?.delegate?.didUpdateWeather(self ?? WeatherManager(), weather: weatherData)
                print(weatherData)
          
            } catch {
                print("Ошибка декодирования данных: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
