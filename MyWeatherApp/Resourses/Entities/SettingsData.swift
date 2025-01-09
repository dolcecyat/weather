//
//  SettingsData.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 17.12.2024.
//

import Foundation

protocol GradeProtocol {
    
}
struct SettingsData {
    
    enum Grades {
        case temp 
        case pressure
        case wind
        case style
    }
    enum tempGrade: String {
        case celsius = "°C"
        case fahrenheit = "°F"
    }
    
    enum windGrade: String, GradeProtocol {
        case ms = "м/с"
        case kmh = "км/ч"
        case milesh = "миль/ч"
        case knots = "узлы"
    }
    
    enum pressureGrade: String, GradeProtocol {
        case gPa = "гПа"
        case mmRtSt = "мм рт.ст."
        case mBar = "мбар"
        case dRtSt = "дюйм рт.ст."
    }
    
    enum styleGrade: String ,GradeProtocol{
        case dark = "Темное"
        case light = "Светлое"
        case system = "Системное"
    }
    
    enum Keys: String ,GradeProtocol {
        case tempSettrings = "temp"
        case pressureSettrings = "pressure"
        case windSettrings = "wind"
        case styleSettrings = "style"
    }
}
