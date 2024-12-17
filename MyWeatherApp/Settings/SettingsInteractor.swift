//
//  SettingsInteractor.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 28.11.2024.
//

import Foundation

protocol SettingsInteractorProtocol: AnyObject {
    var presenter: SettingsPresenterProtocol? { get set }
    func  didChangeSettings(value: String, key: SettingsData.Keys)
    func getCurrentSettings(for key: SettingsData.Keys) -> String
}

class SettingsInteractor: SettingsInteractorProtocol {
    weak var presenter: SettingsPresenterProtocol?
    
    let udStrorage = UDStrorage()
    
    func didChangeSettings(value: String, key: SettingsData.Keys){
        udStrorage.saveSettings(value: value, key: key)
    }
    func getCurrentSettings(for key: SettingsData.Keys) -> String {
        return udStrorage.getSettings(key: key) ?? "Error"
    }
}
