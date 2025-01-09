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
        let url = URL(string: "https://api.vk.com/method/secure.checkToken")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // Укажите параметры запроса
        let params = [
            "token": token,
            "access_token": "8751d2dd8751d2dd8751d2dd1d847721b8887518751d2dde03b5abc5e7e45ffe6c178bd", // Токен сервисного приложения VK
            "v": "5.131"
        ]
        let body = params.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
        request.httpBody = body.data(using: .utf8)

        // Выполнение запроса
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Ошибка запроса: \(String(describing: error))")
                completion(false)
                return
            }

            do {
                // Парсим ответ
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let response = json["response"] as? [String: Any],
                   let success = response["success"] as? Int {
                    completion(success == 1) // Если `success` равен 1, токен действителен
                } else {
                    completion(false)
                }
            } catch {
                print("Ошибка парсинга: \(error)")
                completion(false)
            }
        }
        task.resume()
    }

}
