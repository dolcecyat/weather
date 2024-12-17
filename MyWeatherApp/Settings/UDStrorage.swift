//
//  UDStrorage.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 17.12.2024.
//

import Foundation

class UDStrorage {
    let ud = UserDefaults.standard
//    
//    enum Keys: String {
//        case tempSettrings = "temp"
//        case pressureSettrings = "pressure"
//        case windSettrings = "wind"
//        case styleSettrings = "style"
//    }
    
    func saveSettings (value: String, key: SettingsData.Keys) {
        ud.set(value, forKey: key.rawValue)
    }
    
    func getSettings (key: SettingsData.Keys) -> String? {
        ud.string(forKey: key.rawValue)
    }
}
