//
//  URLHelper.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 09.01.2025.
//

import Foundation

class URLHelper {
    
    static func checkForNil(data: Data?,response: URLResponse?, error: Error?) -> Data {
        guard let endData = data, error == nil else {
            print("Ошибка запроса: \(String(describing: error))")
            return Data()
        }
        return endData
    }
    
    static func makePostRequest(stringUrl: String,parameters: [String: String]) -> URLRequest {
        var request = URLRequest(url: URL(string: stringUrl)!)
        request.httpMethod = "POST"
        let body = parameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
        request.httpBody = body.data(using: .utf8)
        return request
    }
    
    static func makeJsonSerialisation(with data: Data) -> Bool {
        do {
            // Парсим ответ
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
               let response = json["response"] as? [String: Any],
               let success = response["success"] as? Int {
                print(response)
                return success == 1// Если `success` равен 1, токен действителен
            } else {
                return false
            }
        } catch {
            print("Ошибка парсинга: \(error)")
            return false
        }

    }
}

