//
//  SettingsPresenter.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 28.11.2024.
//

import Foundation

protocol SettingsPresenterProtocol: AnyObject {
    var view: SettingsViewProtocol? { get set }
    var router: SettingsRouterProtocol? { get set}
    var interactior: SettingsInteractorProtocol? { get set }
}

class SettingsPresenter: SettingsPresenterProtocol{
    weak var view: SettingsViewProtocol?
    var router: SettingsRouterProtocol?
    var interactior: SettingsInteractorProtocol?
    
    init(router: SettingsRouterProtocol, interactior: SettingsInteractorProtocol) {
        self.router = router
        self.interactior = interactior
    }
}

