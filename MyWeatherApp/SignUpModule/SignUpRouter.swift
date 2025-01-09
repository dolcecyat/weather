//
//  SignUpRouter.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 29.12.2024.
//

import Foundation

protocol SignUpRouterProtocol: AnyObject {
    var presenter: SignUpPresenterProtocol? { get set }
    func showMainScreen()
}

class SignUpRouter: SignUpRouterProtocol {
    weak var presenter: SignUpPresenterProtocol?
    
    func showMainScreen() {
        let VCtoOpen = MainViewController()
        presenter?.view?.navigationController?.pushViewController(VCtoOpen, animated: true)
    }
}
