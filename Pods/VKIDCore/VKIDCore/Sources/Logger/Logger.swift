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
import OSLog

package enum LogLevel: String {
    case debug
    case info
    case warning
    case error
}

package struct LogMessage: ExpressibleByStringInterpolation {
    package typealias StringLiteralType = String
    package typealias ExtendedGraphemeClusterLiteralType = String
    package typealias UnicodeScalarLiteralType = String

    internal let string: String

    package init(stringLiteral value: String) {
        self.string = value
    }
}

package protocol Logging {
    func log(level: LogLevel, message: LogMessage)
    func debug(_ msg: LogMessage)
    func info(_ msg: LogMessage)
    func warning(_ msg: LogMessage)
    func error(_ msg: LogMessage)
}

extension Logging {
    package func debug(_ msg: LogMessage) {
        self.log(level: .debug, message: msg)
    }

    package func info(_ msg: LogMessage) {
        self.log(level: .info, message: msg)
    }

    package func warning(_ msg: LogMessage) {
        self.log(level: .warning, message: msg)
    }

    package func error(_ msg: LogMessage) {
        self.log(level: .error, message: msg)
    }
}

package protocol LoggingBackend: TextOutputStream {}

package struct OSLoggingBackend: LoggingBackend {
    package init() {}

    package mutating func write(_ string: String) {
        os_log("%@", string)
    }
}

package final class Logger: Logging {
    private let subsystem: String
    private var backend: LoggingBackend

    package init(
        subsystem: String,
        backend: LoggingBackend = OSLoggingBackend()
    ) {
        self.subsystem = subsystem
        self.backend = backend
    }

    package func log(level: LogLevel, message: LogMessage) {
        self.backend.write("[\(self.subsystem)][\(level.rawValue)] \(message.string)")
    }
}

package final class LoggerStub: Logging {
    package init() {}
    package func log(level: LogLevel, message: LogMessage) {}
}
