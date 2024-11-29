//
//  WeatherData.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 29.11.2024.
//

import Foundation


struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
    let description : String
}
