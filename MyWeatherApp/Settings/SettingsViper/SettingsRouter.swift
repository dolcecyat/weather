//
//  SettingsRouter.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 28.11.2024.
//

import Foundation

protocol SettingsRouterProtocol: AnyObject{
    var presenter: SettingsPresenterProtocol? { get set }
}

class SettingsRouter: SettingsRouterProtocol {
    weak var presenter:SettingsPresenterProtocol?
}
