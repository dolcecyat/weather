//
// Copyright (c) 2024 - present, LLC “V Kontakte”
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
import VKIDCore

/// Результат авторизации
public typealias AuthResult = Result<UserSession, AuthError>
/// Замыкание с результатом авторизации в качестве параметра
public typealias AuthResultCompletion = (AuthResult) -> Void
/// Результат логаута
public typealias LogoutResult = Result<Void, LogoutError>
/// Результат обновления токенов
public typealias TokenRefreshingResult = Result<(AccessToken, RefreshToken), TokenRefreshingError>
/// Результат обновления пользовательских данных
public typealias UserFetchingResult = Result<User, UserFetchingError>

/// Основные ошибки авторизации
public enum AuthError: Error {
    /// Причина неизвестна
    case unknown

    /// Пользователь прервал/отменил авторизацию
    case cancelled

    /// Процесс авторизации уже начат. Попытка повторного запуска флоу авторизации
    case authAlreadyInProgress

    /// `codeVerifier` не предоставлен для `AuthConfiguration.Flow.publicClientFlow`
    case codeVerifierNotProvided

    /// Сессия в SDK не была создана, но флоу авторизации завершен на стороне сервера сервиса.
    case authCodeExchangedOnYourBackend
}

/// Основные ошибки выполнения логаута
public enum LogoutError: Error {
    /// Причина неизвестна
    case unknown

    /// Невалидный токен
    case invalidAccessToken
}

/// Ошибки обновления токенов: `AccessToken`, `RefreshToken`
public enum TokenRefreshingError: Error {
    /// Рефреш токен невалиден или время жизни токена истекло
    case invalidRefreshToken

    /// Ошибка CSRF
    case stateMismatch

    /// Причина неизвестна
    case unknown
}

/// Ошибки при получении пользовательских данных
public enum UserFetchingError: Error {
    /// Невалидный токен
    case invalidAccessToken

    /// Причина неизвестна
    case unknown
}
