//
//  AuthInteractor.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 28.12.2024.
//

import Foundation

protocol AuthInteractorProtocol: AnyObject {
    var presenter: AuthPresenterProtocol? { get set }
    func logInButtonPressed(login: String,password: String)
}

class AuthInteractor: AuthInteractorProtocol, AuthLogInDelegate {
    
    weak var presenter: AuthPresenterProtocol?
    var accInfo = AccountInfo(login: "", password: "", token: "")
    
    init() {
        FireBaseAuthManager.shared.loginDelegate = self // Устанавливаем текущий объект как делегат
    }
    
    func logInButtonPressed(login: String, password: String) {
        accInfo.login = login
        accInfo.password = password
        FireBaseAuthManager.shared.logIn(login: login, password: password)
    }
    
    func loggedIn(success: Bool) {
        switch success {
        case true:
            presenter?.userLogged()
            UDStrorageManager.shared.saveAccountInfo(login: accInfo.login,password: accInfo.password)
            print("Logged in status: \(success)")
        case false:
            print("Logged in status: \(success)")
        }
    }
}