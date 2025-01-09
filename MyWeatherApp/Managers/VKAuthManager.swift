//
//  VKAuthManager.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 29.12.2024.
//

import VKID
import Foundation
import AuthenticationServices

class VKAuthManager {
    static let shared = VKAuthManager()
    var vkid: VKID?
    var onAuthSuccess: (() -> Void)?
    
    func configure() {
        do {
            vkid = try VKID(
                config: Configuration(
                    appCredentials: AppCredentials(
                        clientId: "52884325",         // Укажите ваш ID приложения VK.
                        clientSecret: "nb0wdfdbu5kVnehKVOM9" // Укажите ваш защищенный ключ.
                    ),
                    loggingEnabled: true // Включите для отладки.
                )
            )
        } catch {
            print("Ошибка инициализации VKID: \(error)")
        }
    }
    // MARK: Auth method
    
    func authorize(authResult: AuthResult) {
        do {
            let session = try authResult.get()
            let token = session.accessToken.value
            UDStrorageManager.shared.saveToken(token: token)
            print("Auth successful")
            onAuthSuccess?()
            
        } catch AuthError.cancelled {
            print("Auth cancelled by user")
        } catch {
            print("Auth failed with error: \(error)")
        }
    }
    
    // MARK: Checking Token
    func checkTokenValidity(token: String, completion: @escaping (Bool) -> Void) {
        completion(false)
        let urlString = "https://api.vk.com/method/secure.checkToken"
        let params = [
            "token": token,
            "access_token": "8751d2dd8751d2dd8751d2dd1d847721b8887518751d2dde03b5abc5e7e45ffe6c178bd",
            "v": "5.131"
        ]
        let request = URLHelper.makePostRequest(stringUrl: urlString, parameters: params)
        // Выполнение запроса
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let saveData = URLHelper.checkForNil(data: data, response: response, error: error)
            
            completion(URLHelper.makeJsonSerialisation(with: saveData))
        }
        task.resume()
    }
}
