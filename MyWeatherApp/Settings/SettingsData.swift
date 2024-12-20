//
//  SettingsData.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 17.12.2024.
//

import Foundation

struct SettingsData {
    
    enum tempGrade: String {
        case celsius = "°C"
        case fahrenheit = "°F"
    }
    
    enum windGrade: String {
        case ms = "м/с"
        case kmh = "км/ч"
        case milesh = "миль/ч"
        case knots = "узлы"
    }
    
    enum pressureGrade: String {
        case gPa = "гПа"
        case mmRtSt = "мм рт.ст."
        case mBar = "мбар"
        case dRtSt = "дюйм рт.ст."
    }
    
    enum styleGrade: String {
        case dark = "Темное"
        case light = "Светлое"
        case system = "Системное"
    }
    
    enum Keys: String {
        case tempSettrings = "temp"
        case pressureSettrings = "pressure"
        case windSettrings = "wind"
        case styleSettrings = "style"
    }
}
