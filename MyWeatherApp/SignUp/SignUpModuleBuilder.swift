//
//  SignUpModuleBuilder.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 29.12.2024.
//


import Foundation

class SignUpModuleBuilder {
    static func build(_ viewController: SignUpViewProtocol)  {
        let interactor = SignUpInteractor()
        let router = SignUpRouter()
        let presenter = SignUpPresenter(router: router, interactor: interactor)
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.presenter = presenter
    }
}
