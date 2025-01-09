//
//  Double+.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 09.01.2025.
//

import Foundation

extension Double {
    func msToKmh(ms: Double) -> String {
        let kmh = ms * 3.6
        let string = String(format: "%.1f", kmh)
        return string
    }
    
    func msToMph(ms: Double) -> String {
        let mph = ms * 2.236
        let string = String(format: "%.1f", mph)
        return string
    }
    
    func msToknots(ms: Double) -> String {
        let knots = ms * 1.9438
        let string = String(format: "%.1f", knots)
        return string
    }
}
