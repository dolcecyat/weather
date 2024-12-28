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

class AuthInteractor: AuthInteractorProtocol, AuthDelegate {
    
    weak var presenter: AuthPresenterProtocol?
    
    var fireBaseAuthManager = FireBaseAuthManager()
    
    init() {
        fireBaseAuthManager.delegate = self // Устанавливаем текущий объект как делегат
    }
    
    func logInButtonPressed(login: String, password: String) {
        fireBaseAuthManager.logIn(login: login, password: password)
    }
    
    func loggedIn(success: Bool) {
        print("Logged in status: \(success)")
    }
}
