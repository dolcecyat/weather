//
//  WeatherManager.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 29.11.2024.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error:Error)
}


// Структуры для декодирования данных
struct WeatherData: Codable {
    let now: Int
    let fact: Fact
}

struct Fact: Codable {
    let temp: Int
    let feels_like: Int
    let condition: String
}

class WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let apiKey = "1668adb2-c3d2-4f97-9c57-932f9a73d1bf"  // Замените на ваш ключ доступа
        let urlString = "https://api.weather.yandex.ru/v2/forecast?\(latitude)\(longitude)lang=ru_RU&limit=7&hours=false&extra=false"
        
        guard let url = URL(string: urlString) else {
            print("Некорректный URL")
            return
        }
        
        var request = URLRequest(url: url)

        request.allHTTPHeaderFields = ["X-Yandex-API-Key" : apiKey]
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
                print(data)
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                print("Температура: \(weatherData.fact.temp)°C")
                print("Ощущается как: \(weatherData.fact.feels_like)°C")
                print("Погодное условие: \(weatherData.fact.condition)")
            } catch {
                print("Ошибка декодирования данных: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}
