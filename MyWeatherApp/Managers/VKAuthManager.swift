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
    
    func authorize(authResult: AuthResult) {
        do {
            let session = try authResult.get()
            print("Auth succeeded with token: \(session.accessToken)")
             let token = session.idToken.value
            UDStrorageManager.shared.saveToken(token: token)
        } catch AuthError.cancelled {
            print("Auth cancelled by user")
        } catch {
            print("Auth failed with error: \(error)")
        }
    }
}
