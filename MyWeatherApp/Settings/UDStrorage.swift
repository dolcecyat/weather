//
//  UDStrorage.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 17.12.2024.
//

import Foundation

class UDStrorage {
    let ud = UserDefaults.standard
    
    static let shared = UDStrorage()
    
    func saveSettings (value: String, key: SettingsData.Keys) {
        ud.set(value, forKey: key.rawValue)
        print("saved")
    }
    
    func getSettings (key: SettingsData.Keys) -> String? {
        ud.string(forKey: key.rawValue)
    }
}
