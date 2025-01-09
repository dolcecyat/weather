//
//  SettingsModuleBuilder.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 28.11.2024.
//

import Foundation

class SettingsModuleBuilder {
    static func build(_ viewController: SettingsViewProtocol)  {
        let interactor = SettingsInteractor()
        let router = SettingsRouter()
        let presenter = SettingsPresenter(router: router, interactor: interactor)
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.presenter = presenter
    }
}
