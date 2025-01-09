//
//  AuthRouter.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 28.12.2024.
//

import Foundation

protocol AuthRouterProtocol: AnyObject {
    var presenter: AuthPresenterProtocol? { get set }
    func showSignUpScreen()
    func showMainScreen()
}

class AuthRouter: AuthRouterProtocol {
    weak var presenter: AuthPresenterProtocol?
    
    func showSignUpScreen() {
        let VCToOpen = SignUpViewController()
        presenter?.view?.navigationController?.pushViewController(VCToOpen, animated: true)
    }

    func showMainScreen() {
        let VCToOpen = MainViewController()
        presenter?.view?.navigationController?.pushViewController(VCToOpen, animated: true)
    }
}
