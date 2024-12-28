//
//  AuthPresenter.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 28.12.2024.
//

import Foundation

protocol AuthPresenterProtocol: AnyObject {
    var view: AuthViewProtocol? { get set }
    var router: AuthRouterProtocol? { get set}
    var interactor: AuthInteractorProtocol? { get set }
    
    func logInButtonPressed(login: String,password: String)
    func signUpButtonPressed()
}

class AuthPresenter: AuthPresenterProtocol {
    
    weak var view: AuthViewProtocol?
    var router: AuthRouterProtocol?
    var interactor: AuthInteractorProtocol?
    
    init(router: AuthRouterProtocol, interactor: AuthInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    func logInButtonPressed(login: String,password: String) {
        interactor?.logInButtonPressed(login: login, password: password)
    }
    
    func signUpButtonPressed(){
        
    }
}
