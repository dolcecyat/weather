//
//  MainModuleBuilder.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 28.11.2024.
//

import Foundation
import UIKit

class MainModuleBuilder {
    static func build(_ viewController: MainViewProtocol)  {
        let interactor = MainInteractor()
        let router = MainRouter()
        let presenter = MainPresenter(router: router, interactor: interactor)
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.presenter = presenter
    }
}
