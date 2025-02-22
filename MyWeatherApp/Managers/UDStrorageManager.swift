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
    
    func saveAccountInfo (login: String, password: String) {
        ud.set(login, forKey: "login")
        ud.set(password, forKey: "password")
    }
    
    func saveToken(token: String) {
        ud.set(token, forKey: "vkUserToken")
    }
    
    func getToken()-> String {
        ud.string(forKey: "vkUserToken") ?? ""
    }
    
    func getCurrentUserInfo() -> [String] {
        guard let password = ud.string(forKey: "password") else { return []}
        guard let login = ud.string(forKey: "login") else { return []}
        return [login, password]
    }
}
