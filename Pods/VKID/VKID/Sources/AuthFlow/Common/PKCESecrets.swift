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

import CommonCrypto
import Foundation

/// Для повышения безопасности авторизации используется [PKCE](https://datatracker.ietf.org/doc/html/rfc7636)
public struct PKCESecrets: Equatable {
    public enum CodeChallengeMethod: String {
        case s256
    }

    /// [Случайно сгенерированная строка](https://datatracker.ietf.org/doc/html/rfc7636#section-4.1)
    public var codeVerifier: String?
    /// [Захешированный codeVerifier](https://datatracker.ietf.org/doc/html/rfc7636#section-4.2)
    public var codeChallenge: String
    /// [Алгоритм хеширования](https://datatracker.ietf.org/doc/html/rfc7636#section-4.3)
    /// На данный момент используется s256
    public var codeChallengeMethod: CodeChallengeMethod
    /// Случайно сгенерированная строка для повышения безопасности от [CSRF-атак](https://datatracker.ietf.org/doc/html/rfc6749#section-10.12)
    public var state: String

    /// Инициализатор для передачи параметров PKCE в SDK
    public init(
        codeVerifier: String? = nil,
        codeChallenge: String,
        codeChallengeMethod: CodeChallengeMethod = .s256,
        state: String
    ) {
        self.codeVerifier = codeVerifier
        self.codeChallenge = codeChallenge
        self.codeChallengeMethod = codeChallengeMethod
        self.state = state
    }

    /// Инициализатор, который сгенерирует параметры PKCE
    public init() throws {
        self = try PKCESecretsS256Generator().generateSecrets()
    }

    internal init(pkceSecretsGenerator: PKCESecretsGenerator) throws {
        self = try pkceSecretsGenerator.generateSecrets()
    }
}

internal protocol PKCESecretsGenerator {
    func generateSecrets() throws -> PKCESecrets
}

internal final class PKCESecretsS256Generator: PKCESecretsGenerator {
    internal enum Error: Swift.Error {
        case securityServicesError(OSStatus)
        case failedToGenerateChallenge
    }

    internal func generateSecrets() throws -> PKCESecrets {
        let octets = try self.generateRandomBytes(length: 32)
        let verifier = octets.base64URLEncoded()
        let challenge = try generateChallenge(for: verifier)
        return PKCESecrets(
            codeVerifier: verifier,
            codeChallenge: challenge,
            codeChallengeMethod: .s256,
            state: UUID().uuidString
        )
    }

    private func generateRandomBytes(length: Int) throws -> [UInt8] {
        var octets = [UInt8](repeating: 0, count: length)
        let status = SecRandomCopyBytes(kSecRandomDefault, octets.count, &octets)
        if status == errSecSuccess {
            return octets
        } else {
            throw Error.securityServicesError(status)
        }
    }

    private func generateChallenge(for verifier: String) throws -> String {
        let challenge = verifier
            .data(using: .ascii)?
            .sha256()
            .base64URLEncoded()
        if let challenge {
            return challenge
        }
        throw Error.failedToGenerateChallenge
    }
}

extension Sequence<UInt8> {
    fileprivate func base64URLEncoded() -> String {
        Data(self)
            .base64EncodedString() // Regular base64 encoder
            .replacingOccurrences(of: "=", with: "") // Remove any trailing '='s
            .replacingOccurrences(of: "+", with: "-") // 62nd char of encoding
            .replacingOccurrences(of: "/", with: "_") // 63rd char of encoding
            .trimmingCharacters(in: .whitespaces)
    }
}

extension Data {
    fileprivate func sha256() -> Self {
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        self.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(self.count), &hash)
        }
        return Data(hash)
    }
}
