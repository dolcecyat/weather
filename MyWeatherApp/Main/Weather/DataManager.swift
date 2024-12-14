//
//  Untitled.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 12.12.2024.
//
import Foundation
import UIKit

class DataManager {
    
    func getConditionName(condition: FactCondition) -> String {
        
        switch condition {
        case .clear: return "Ясно"
        case .partlyCloudy: return "Малооблачно"
        case .cloudy: return "Облачно с прояснениями"
        case .overcast: return "Пасмурно"
        case .drizzle: return "Морось"
        case .lightRain: return "Небольшой дождь"
        case .rain: return "Дождь"
        case .moderateRain: return "Умеренно сильный дождь"
        case .heavyRain: return "Сильный дождь"
        case .continuousHeavyRain: return "Длительный сильный дождь"
        case .showers: return "Ливень"
        case .wetSnow: return "Дождь со снегом"
        case .lightSnow: return "Небольшой снег"
        case .snow: return "Снег"
        case .snowShowers: return "Снегопад"
        case .hail: return "Град"
        case .thunderstorm: return "Гроза"
        case .thunderstormWithRain: return "Дождь с грозой"
        case .thunderstormWithHail: return "Гроза с градом"
        }
    }
    
    func getConditionImage(condition: FactCondition) -> UIImage {
        switch condition {
        case .clear: return UIImage(systemName: "sun.horizon")!
        case .partlyCloudy: return UIImage(systemName: "cloud.sun.fill")!
        case .cloudy: return UIImage(systemName: "smoke.fill")!
        case .overcast: return UIImage(systemName: "cloud.fill")!
        case .drizzle: return UIImage(systemName: "cloud.drizzle.fill")!
        case .lightRain: return UIImage(systemName: "cloud.rain")!
        case .rain: return UIImage(systemName: "cloud.rain")!
        case .moderateRain: return UIImage(systemName: "cloud.rain")!
        case .heavyRain: return UIImage(systemName: "cloud.heavyrain.fill")!
        case .continuousHeavyRain: return UIImage(systemName: "cloud.heavyrain.fill")!
        case .showers: return UIImage(systemName: "cloud.heavyrain.fill")!
        case .wetSnow: return UIImage(systemName: "cloud.hail.fill")!
        case .lightSnow: return UIImage(systemName: "cloud.sleet.fill")!
        case .snow: return UIImage(systemName: "cloud.snow.fill")!
        case .snowShowers: return UIImage(systemName: "cloud.snow.fill")!
        case .hail: return UIImage(systemName: "cloud.hail.fill")!
        case .thunderstorm: return UIImage(systemName: "cloud.bolt.fill")!
        case .thunderstormWithRain: return UIImage(systemName: "cloud.bolt.rain.fill")!
        case .thunderstormWithHail: return UIImage(systemName: "cloud.bolt.rain.fill")!
        }
    }
    
    func getDate(from dateString: String) -> String {
        var formattedDate: String = ""
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "d MMMM EEEE"
            outputFormatter.locale = Locale(identifier: "ru_RU")
             formattedDate = outputFormatter.string(from: date)
        } else {
            print("Ошибка в преобразовании даты.")
        }
        return formattedDate
    }
}
