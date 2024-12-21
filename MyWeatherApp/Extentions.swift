//
//  Extentions.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 19.12.2024.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(view : UIView) {
        view.layer.cornerRadius = 20
    }
}

extension Int {
    func ctof (intC: Int) -> Int {
        let cToF = (intC * 9/5) + 32
        return cToF
    }
}

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

