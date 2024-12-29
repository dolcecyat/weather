//
//  SignUpInteractor.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 29.12.2024.
//

import Foundation

protocol SignUpInteractorProtocol: AnyObject {
    var presenter: SignUpPresenterProtocol? { get set }
    func signUpButtonPressed(login: String,password: String)
}

class SignUpInteractor: SignUpInteractorProtocol, SignUpDelegate {
  
    weak var presenter: SignUpPresenterProtocol?
    var accInfo = AccountInfo(login: "", password: "",token: "")
    
    init() {
        FireBaseAuthManager.shared.signUpDelegate = self // Устанавливаем текущий объект как делегат
    }
    
    func signUpButtonPressed(login: String, password: String) {
        accInfo.login = login
        accInfo.password = password
        FireBaseAuthManager.shared.signUp(login: login, password: password)
    }
    
    func signUp(success: Bool) {
        switch success {
        case true:
            UDStrorageManager.shared.saveAccountInfo(login: accInfo.login, password: accInfo.password)
            print("Sign Up in status: \(success)")
        case false:
            print("Sign Up in status: \(success)")
        }
    }
}
