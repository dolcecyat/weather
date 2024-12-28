//
//  FireBaseAuthManager.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 28.12.2024.
//

import Foundation
import FirebaseAuth

protocol AuthDelegate: AnyObject {
    func loggedIn(success: Bool)
}

class FireBaseAuthManager {
    var delegate: AuthDelegate?
    
    func logIn(login: String, password: String) {
        Auth.auth().signIn(withEmail: login, password: password) { [weak self] authResult, error in
            if authResult?.user != nil {
                self?.delegate?.loggedIn(success: true) // Уведомляем делегата
            } else {
                self?.delegate?.loggedIn(success: false) // Сообщаем об ошибке
            }
        }
    }
}
