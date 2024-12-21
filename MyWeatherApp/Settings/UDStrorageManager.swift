//
//  UDStrorage.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 17.12.2024.
//

import Foundation

class UDStrorageManager {
    let ud = UserDefaults.standard
    
    static let shared = UDStrorageManager()
    
    func saveSettings (value: String, key: SettingsData.Keys) {
        ud.set(value, forKey: key.rawValue)
        print("saved")
    }
    
    func getSettings (key: SettingsData.Keys) -> String? {
        ud.string(forKey: key.rawValue)
    }
    
    func didChangeSettings(value: String,key: SettingsData.Keys) {
        saveSettings(value: value, key: key)
    }
    
    func getCurrentSettings(for key: SettingsData.Keys) -> String {
        getSettings(key: key) ?? "0"
    }
}
