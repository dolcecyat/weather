//
//  AuthModuleBuilder.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 28.12.2024.
//

import Foundation

class AuthModuleBuilder {
    static func build(_ viewController: AuthViewProtocol)  {
        let interactor = AuthInteractor()
        let router = AuthRouter()
        let presenter = AuthPresenter(router: router, interactor: interactor)
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.presenter = presenter
    }
}
