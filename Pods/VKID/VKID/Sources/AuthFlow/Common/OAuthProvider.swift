//
// Copyright (c) 2023 - present, LLC “V Kontakte”
//
// 1. Permission is hereby granted to any person obtaining a copy of this Software to
// use the Software without charge.
//
// 2. Restrictions
// You may not modify, merge, publish, distribute, sublicense, and/or sell copies,
// create derivative works based upon the Software or any part thereof.
//
// 3. Termination
// This License is effective until terminated. LLC “V Kontakte” may terminate this
// License at any time without any negative consequences to our rights.
// You may terminate this License at any time by deleting the Software and all copies
// thereof. Upon termination of this license for any reason, you shall continue to be
// bound by the provisions of Section 2 above.
// Termination will be without prejudice to any rights LLC “V Kontakte” may have as
// a result of this agreement.
//
// 4. Disclaimer of warranty and liability
// THE SOFTWARE IS MADE AVAILABLE ON THE “AS IS” BASIS. LLC “V KONTAKTE” DISCLAIMS
// ALL WARRANTIES THAT THE SOFTWARE MAY BE SUITABLE OR UNSUITABLE FOR ANY SPECIFIC
// PURPOSES OF USE. LLC “V KONTAKTE” CAN NOT GUARANTEE AND DOES NOT PROMISE ANY
// SPECIFIC RESULTS OF USE OF THE SOFTWARE.
// UNDER NO CIRCUMSTANCES LLC “V KONTAKTE” BEAR LIABILITY TO THE LICENSEE OR ANY
// THIRD PARTIES FOR ANY DAMAGE IN CONNECTION WITH USE OF THE SOFTWARE.
//

import Foundation

/// Провайдер авторизации
public struct OAuthProvider: Equatable, Codable, CaseIterable {
    /// Все доступные провайдеры
    public static var allCases: [OAuthProvider] = [
        .vkid, .ok, .mail,
    ]
    /// Провайдер авторизации через VKID
    public static let vkid = Self(rawType: .vkid)

    /// Провайдер авторизации через Одноклассники
    public static let ok = Self(rawType: .ok)

    /// Провайдер авторизации через MailRu
    public static let mail = Self(rawType: .mail)

    internal enum RawType: String, Equatable, Codable {
        case vkid = "vkid"
        case ok = "ok_ru"
        case mail = "mail_ru"
    }

    internal let type: RawType

    private init(rawType: RawType) {
        self.type = rawType
    }
}

/// Описывает конфигурацию OAuth провайдеров для авторизации
public struct OAuthProviderConfiguration {
    /// Основной провайдер авторизации.
    public let primaryProvider: OAuthProvider

    /// Альтернативные провайдеры авторизации
    public var alternativeProviders: [OAuthProvider]

    public init(alternativeProviders: [OAuthProvider] = []) {
        self.init(
            primaryProvider: .vkid,
            alternativeProviders: alternativeProviders
        )
    }

    internal init(
        primaryProvider: OAuthProvider,
        alternativeProviders: [OAuthProvider] = []
    ) {
        self.primaryProvider = primaryProvider
        // Исключаем основной провайдер из списка альтернативных, чтобы не было дублирования
        self.alternativeProviders =
            alternativeProviders.filter { [primary = primaryProvider] provider in
                provider.type != primary.type
            }
    }
}
