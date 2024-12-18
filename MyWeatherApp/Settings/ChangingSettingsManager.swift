//
//  ChengingSettingsManager.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 18.12.2024.
//

import Foundation

class ChangingSettingsManager {
    
    let ud = UDStrorage.shared
    
    func didChangeSettings(value: String,key: SettingsData.Keys) {
        ud.saveSettings(value: value, key: key)
    }
    
    func getCurrentSettings(for key: SettingsData.Keys) -> String {
        ud.getSettings(key: key) ?? "0"
    }
}
