//
//  FireBaseAuthManager.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 28.12.2024.
//

import Foundation
import FirebaseAuth

protocol AuthLogInDelegate: AnyObject {
    func loggedIn(success: Bool)
}

protocol SignUpDelegate: AnyObject {
    func signUp(success: Bool)
}
class FireBaseAuthManager {
    
    static let shared = FireBaseAuthManager()
    var loginDelegate: AuthLogInDelegate?
    var signUpDelegate: SignUpDelegate?
    
    func logIn(login: String, password: String) {
        Auth.auth().signIn(withEmail: login, password: password) { [weak self] authResult, error in
            if authResult?.user != nil {
                self?.loginDelegate?.loggedIn(success: true) // Уведомляем делегата
            } else {
                self?.loginDelegate?.loggedIn(success: false) // Сообщаем об ошибке
            }
        }
    }
    
    func signUp(login: String, password: String) {
        Auth.auth().createUser(withEmail: login, password: password) { [weak self] authResult, error in
            if authResult?.user != nil {
                self?.signUpDelegate?.signUp(success: true) 
            } else {
                self?.signUpDelegate?.signUp(success: false)
            }
        }
    }
}
