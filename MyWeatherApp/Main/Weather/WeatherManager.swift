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
        let apiKey = "1668adb2-c3d2-4f97-9c57-932f9a73d1bf"
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=\(latitude)&lon=\(longitude)&lang=ru_RU&limit=7&hours=true&extra=true"
        
        guard let url = URL(string: urlString) else {
            print("Некорректный URL")
            return
        }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["X-Yandex-API-Key" : apiKey]
        print(url)
        // Выполняем запрос
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
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
                self.delegate?.didUpdateWeather(self, weather: weatherData)
                print(weatherData)
          
            } catch {
                print("Ошибка декодирования данных: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
