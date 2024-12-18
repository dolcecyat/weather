//
//  SettingsInteractor.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 28.11.2024.
//

import Foundation

protocol SettingsInteractorProtocol: AnyObject {
    var presenter: SettingsPresenterProtocol? { get set }
}

class SettingsInteractor: SettingsInteractorProtocol {
    weak var presenter: SettingsPresenterProtocol?
}
