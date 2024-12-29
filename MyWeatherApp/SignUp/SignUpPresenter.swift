//
//  SignUpPresenter.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 29.12.2024.
//

import Foundation

protocol SignUpPresenterProtocol: AnyObject {
    var view: SignUpViewProtocol? { get set }
    var router: SignUpRouterProtocol? { get set}
    var interactor: SignUpInteractorProtocol? { get set }
    
    func signUpButtonPressed(login: String,password: String)
}

class SignUpPresenter: SignUpPresenterProtocol {
    
    weak var view: SignUpViewProtocol?
    var router: SignUpRouterProtocol?
    var interactor: SignUpInteractorProtocol?
    
    init(router:SignUpRouterProtocol, interactor: SignUpInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    func signUpButtonPressed(login: String,password: String) {
        interactor?.signUpButtonPressed(login: login, password: password)
        router?.showMainScreen()
    }
}
