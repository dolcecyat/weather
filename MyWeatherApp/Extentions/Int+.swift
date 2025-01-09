//
//  Int+.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 09.01.2025.
//

import Foundation

extension Int {
    func ctof (intC: Int) -> Int {
        let cToF = (intC * 9/5) + 32
        return cToF
    }
}
