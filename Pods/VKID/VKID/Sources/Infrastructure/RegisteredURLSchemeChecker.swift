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

internal enum RegisteredURLSchemeChecker {
    private static let registeredQueriesSchemes = Bundle.main.infoDictionary
        .flatMap { $0["LSApplicationQueriesSchemes"] as? [String] } ?? []
    private static let registeredURLSchemes = Bundle.main.infoDictionary
        .flatMap { $0["CFBundleURLTypes"] as? [[String: Any]] }?
        .flatMap { $0["CFBundleURLSchemes"] as? [String] ?? [] } ?? []

    private static let silentAuthScheme = "vkauthorize-silent"
    private static let helpLink = "https://vk.cc/cE6hnt"
    private static let isSilentAuthSchemeRegistered =
        registeredQueriesSchemes.contains(silentAuthScheme)

    internal static func assertRequiredURLSchemes(clientId: String) {
        guard self.isSilentAuthSchemeRegistered else {
            fatalError(
                """
                Info.plist does not contain \(self.silentAuthScheme) in LSApplicationQueriesSchemes key. \
                More details at \(self.helpLink)
                """
            )
        }
        let clientIdScheme = "vk\(clientId)"
        guard self.registeredURLSchemes.contains(clientIdScheme) else {
            fatalError(
                """
                Info.plist does not contain \(clientIdScheme) in CFBundleURLTypes key. \
                More details at \(self.helpLink)
                """
            )
        }
    }
}
