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

internal struct AuthCodeResponse: Equatable {
    let code: String
    let state: String
    let serverProvidedDeviceId: String
}

internal protocol AuthCodeResponseParser {
    func parseAuthCodeResponse(from url: URL) throws -> AuthCodeResponse
    func parseCallbackMethod(from url: URL) throws -> String?
}

internal final class AuthCodeResponseParserImpl: AuthCodeResponseParser {
    func parseAuthCodeResponse(from url: URL) throws -> AuthCodeResponse {
        guard let queryItems = queryItems(from: url) else {
            throw AuthFlowError.invalidAuthCallbackURL
        }
        guard let state = queryItems.value(byName: "state"),
              let code = queryItems.value(byName: "code"),
              let deviceId = queryItems.value(byName: "device_id")
        else {
            if let _ = queryItems.value(byName: "error") {
                throw AuthFlowError.authorizationFailed
            }
            throw AuthFlowError.invalidAuthCallbackURL
        }
        return .init(
            code: code,
            state: state,
            serverProvidedDeviceId: deviceId
        )
    }

    func parseCallbackMethod(from url: URL) throws -> String? {
        guard
            let queryItems = queryItems(from: url),
            let method = queryItems
                .first(where: { $0.name == URLQueryItem.authProviderMethod.name })?
                .value
        else {
            throw AuthFlowError.invalidAuthCallbackURL
        }

        return method
    }

    private func queryItems(from url: URL) -> [URLQueryItem]? {
        let components = URLComponents(
            url: url,
            resolvingAgainstBaseURL: false
        )

        return components?.queryItems
    }
}

extension [URLQueryItem] {
    func value(byName name: String) -> String? {
        self.first(where: { $0.name == name })?.value
    }
}
